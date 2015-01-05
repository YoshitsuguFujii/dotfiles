run_segment() {
  ## vm_stat コマンドのチェック
  if ! type vm_stat > /dev/null 2>&1; then
      exit 1
  fi

  #
  # メモリ使用率(%)を求める
  #   精度は小数点第1位までとする
  #
  calculate_used_mem() {
      # vm_stat
      #  page size of 4096 bytes
      VM_STAT=$(vm_stat)
      PAGES_FREE=$(echo "$VM_STAT" | awk '/Pages free/ {print $3}' | tr -d '.')
      PAGES_ACTIVE=$(echo "$VM_STAT" | awk '/Pages active/ {print $3}' | tr -d '.')
      PAGES_INACTIVE=$(echo "$VM_STAT" | awk '/Pages inactive/ {print $3}' | tr -d '.')
      PAGES_SPECULATIVE=$(echo "$VM_STAT" | awk '/Pages speculative/ {print $3}' | tr -d '.')
      PAGES_WIRED=$(echo "$VM_STAT" | awk '/Pages wired down/ {print $4}' | tr -d '.')

      # 空きメモリ
      FREE_MEM=$(($PAGES_FREE + $PAGES_SPECULATIVE))

      # 使用中メモリ
      USED_MEM=$(($PAGES_ACTIVE + $PAGES_INACTIVE + $PAGES_WIRED))

      # 合計
      TOTAL_MEM=$(($FREE_MEM + $USED_MEM))


      # 使用中メモリ(%)
      #  小数点第1位まで求めて後から小数点文字(ドット)を挿入
      USED_MEM_PERCENT=$(echo "$(($USED_MEM * 1000 / $TOTAL_MEM))" | sed -e 's/\(.*\)\([0-9]\)/\1.\2/' -e 's/^\./0./')
      echo "${USED_MEM_PERCENT}"

      # RET
      return 0
  }

  RET=0
  ## メイン処理 -----


  calculate_used_mem

  RET=$?

  ## デバッグ -----
  #DEBUG=yes debug

  ## exit
  exit $RET
}
