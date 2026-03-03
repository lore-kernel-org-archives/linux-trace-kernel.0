Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071C1A8F97
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541486; cv=pass; b=oAAuDeZ1lXZts6DmtVA8uIgousePx0m0UKsylq4p53+c6GBsKzLeR+5kMpaw1fuZQLP4t/0VCv4Z68x8ZfFHAijxhL2XWJxOn9I5F30I5OqD6l6E/FI+kyBPEHNRA8CnmaM5iKJJG92LXy76iEa9We37WHt2cgbYFBTu7JTutwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541486; c=relaxed/simple;
	bh=SE8OsuOearTbpLewa/D9O40p1Vtj0EdgohxwdO4h3qg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RgwwjtatLUoqlSOLytnOouVtkwWy7PX/0+3m7xkeo+gfxSk5cvyK88CxjZSMBzedzkl8m3uygq+f7Ufo2/8j/YMSiFCMu3r6tRGTi80uV9q5uV5znq6tGF9eKDym8qjEZYNB1kin3coRmVvEqkpMueNe0E3tJyX+9yk7znd4Qk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIv2vAIm; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIv2vAIm"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3598cab697eso1291330a91.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 04:38:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772541484; cv=none;
        d=google.com; s=arc-20240605;
        b=OQT0rIUAoFhkSnkb4ZIBO2C84Vql+Gz9gTNobtb3RQjhsHu99/AJxcYXJ5Xf/Lrgdm
         SqIvwVW5Cz2TrLlzHus1AtaEreb4gkLkHN34EKrPxx8KZ/SGtzT5t+UIGoZYiYgkjJRZ
         h+yDW6MuoHtDCRRwti87iQHyjcl3qi0FYgAqrgTNI3DgkyQqc2fF7dTWJQsf68otOg7K
         BULaD8qgeQBiaoMYlddhQfNY0Ji1rRoBGCc87zxjvWGEQDfaZcmS31PtsX6FMz1bOh/F
         /5pVY2s0vE4awvf2dYlWPkeVI4E3zqxCttTqUMgL+j1mbj0A6phz2Qp+tepQLLGZIECb
         TaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3Od8VmsAkxkDfornZBSHD3NThhpuDKPeufz3L6FQsdo=;
        fh=1hYEv1UO9+LwvXHhhK0btBHXQe6UPGxxxS9aCc5tmDY=;
        b=C+c397n6AjELpGdYoEayMpOdIdN0vwb5qD77C11jIDCeGGP7CYegAeDSDY4bXEf9Io
         x2cvXmMtG7sUgrZJr2dHN38WWQVz2zB1S3MjWVI1is8QnJKQRGa0dWaeqXlGntiZEXS2
         yYrg+rhkMXC1CNBNXgCVYSx5w5dSNjIgR2PTk8czYh4lUc9Vjh99G+NgGPEh3e6qVXeB
         Wd7w1GIKreye21rzhemcgJc+0+6AITDeoCoNxro+f0yDNCAII6RENrxJWftPw8w5uA8f
         p1AH0g48Rl92RF9QgehChVNUMiOaBvwbOCRer305AARsY6BsRACI+uENRudOUCQ9cCNM
         SmDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772541484; x=1773146284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Od8VmsAkxkDfornZBSHD3NThhpuDKPeufz3L6FQsdo=;
        b=nIv2vAImkNUX82TjIXd8M5ckaTLMaN9l9A3H6eponq9/VEMByLn53QW9aMHi85+9Se
         JTa8gXKYlAXe7r8TBsOTMx7FfbusxJTrSKzKoSfzDXPCWQQOLg/b5VSyI6aYSrhx/3Xb
         r5OL4ImrsGtiiYfXMvDc4r68e9iuVnAWcmvBluHPraE3pHcUCXNpMBm6Wr1kIzgfUb3f
         pRq5QK4Y07kR3K7Mc3hp/FWmBDx1BXoYQvTb2F7cjV5EvRuAmBPce1gm07+Kl9ka/tNZ
         FvxCDth/Jish/Dzjxn4K3qBTNZtCG54BqT7oCyMn29XXVJzLsdGdRmP7uHHDC25xy54X
         7SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541484; x=1773146284;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Od8VmsAkxkDfornZBSHD3NThhpuDKPeufz3L6FQsdo=;
        b=ia9CUcFr9pezAu1wQ39gU162Pg/TxQyDZmzBMk97d8Xe7hqQOWiVMprX1mTcnfnvR2
         x0sHDxsPaPZZZstk9jnR0gJO52qcY35iaW4ieeXblhk4GiOcKem7LKxUSWor6rF247sD
         ibaIWp7FZi7fwKbv5iNhT1SMvAF+FcOiG9i90zy+OuX8/2wSmhJItA8Yci4jchn5sDkc
         VE6bhhfcfCbk/jNfv4HaGJ1yqALK9nz6gtZ0/alTgCRJtbwQVlZiaWcCnV6S6G8q1FId
         j9AAM7cyKMbHC23FHsEH7xLo7OPZ+7wZahLcej7TN6RerLdddeeVNc6MABFp30IltdgD
         gEew==
X-Forwarded-Encrypted: i=1; AJvYcCWiWAalDUkzVLwSQxeOWuKM5ST/WYOURNFQyOqTpuBkvkey6ZLLDtSHCpkq0xM5UdFkqjJLrYBBWDJDk/xM+fLNve8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEy0XNpa+ifdKRgGY15E0IAJnYxbO0o9B1DsqFZEGq/LhuX1OQ
	pSenm1lf2mHXDIDcQiBkctuqpCxzVeJx1s/9QJMTB/JXBU5qQv5AylywK5RemFL5RvhSCt6UqqQ
	cNA5LHJDukhUlKt5ALSbqB32aT1u0fSA=
X-Gm-Gg: ATEYQzy3Vz3aEFsTq1MJzNGHwSZ4NRyJyvkRbpDIDLfraQZnfBfd57acNYB1IyvFyp5
	cZ/PSBZZNgbvBXyj06xLkohbLIGiBei3NTcKnNos6eEnK8r9yebUMr0fTcvmKOwdG947UWiAkAq
	9lu8Yrbj2A8L1MfeFyhmuvlHmVO42yrLd19MFmJsTEwb16+DxgqIfHMmKnAoOil79H2Lreif9p2
	E/GcCV9sgZe13AGY7h/cCw9IorfTdsvhCDwwi5izF8Iz/4GUOP3XYEQ+WG8V6w+KZyBCeVKbow2
	T0cgmkI=
X-Received: by 2002:a17:90b:5289:b0:359:806c:7aa1 with SMTP id
 98e67ed59e1d1-3599ce03d7emr2037572a91.2.1772541484045; Tue, 03 Mar 2026
 04:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Tue, 3 Mar 2026 20:37:54 +0800
X-Gm-Features: AaiRm535xsaj4VoSKoOw9tJiv_BU8fScEnpA3N2KgqFZaXGTc84pg3falQ7tcTI
Message-ID: <CAPHJ_VLapzvWHz_ot4uvxSJ_Z3ubtCCp=_ZVReh7KAwjxu5uFQ@mail.gmail.com>
Subject: [BUG] WARNING in __perf_event_account_interrupt (kernel/events/core.c:2797)
To: peterz@infradead.org, mingo@redhat.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a WARNING triggered by a syzkaller reproducer on Linux 7.0.0-rc1.

The kernel hits a WARN in perf events interrupt accounting:

WARNING: kernel/events/core.c:2797 at __perf_event_account_interrupt+0x485/0x530

It is triggered from the perf overflow path while closing a perf_event
fd created for a tracepoint (PERF_TYPE_TRACEPOINT). The call trace
shows:

__perf_event_overflow()
perf_tp_event()
...
__x64_sys_close()

This looks like a potential state inconsistency / reentrancy issue
between tracepoint-perf event handling (overflow/accounting) and event
close/teardown paths, causing __perf_event_account_interrupt() to hit
a WARN_ON.

log:

[  109.197980] Call Trace:
[  109.198578]  <TASK>
[  109.199163]  __perf_event_overflow+0xb6/0xa00
[  109.200270]  ? perf_tp_event+0x703/0xcd0
[  109.201256]  perf_swevent_overflow+0xac/0x150
[  109.202321]  perf_swevent_event+0x14d/0x2e0
[  109.203372]  perf_tp_event+0x3d8/0xcd0
[  109.204320]  ? __perf_tp_event_target_task+0x540/0x540
[  109.205578]  ? __lock_acquire+0x55a/0x1ef0
[  109.206595]  ? lock_acquire+0x199/0x2f0
[  109.207556]  ? find_held_lock+0x2b/0x80
[  109.208512]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.209655]  ? _perf_event_period+0x1b2/0x240
[  109.210714]  ? perf_event_refresh+0x100/0x100
[  109.211984]  ? __might_fault+0x151/0x190
[  109.212905]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.214104]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.215238]  ? _perf_ioctl+0x147/0x1d40
[  109.216203]  ? perf_trace_run_bpf_submit+0xef/0x180
[  109.217378]  perf_trace_run_bpf_submit+0xef/0x180
[  109.218542]  perf_trace_lock_acquire+0x385/0x590
[  109.219684]  ? lock_release+0xc9/0x2b0
[  109.220824]  ? perf_trace_lock+0x510/0x510
[  109.221820]  ? __mutex_unlock_slowpath+0x157/0x760
[  109.223132]  ? _mutex_trylock_nest_lock+0x370/0x370
[  109.224302]  ? perf_event_ctx_lock_nested+0x89/0x4d0
[  109.225533]  lock_acquire+0xdf/0x2f0
[  109.226428]  ? file_close_fd+0x4d/0x80
[  109.227390]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.228570]  _raw_spin_lock+0x2b/0x40
[  109.229517]  ? file_close_fd+0x4d/0x80
[  109.230481]  file_close_fd+0x4d/0x80
[  109.231386]  __x64_sys_close+0x38/0x120
[  109.232343]  do_syscall_64+0x115/0x650
[  109.233305]  entry_SYSCALL_64_after_hwframe+0x4b/0x53


Reproducer:
C reproducer: https://pastebin.com/raw/GJtNs8JE
console output: https://pastebin.com/raw/zGwk1RhB
kernel config: https://pastebin.com/raw/g6ZhXQ79

Kernel:
git tree: torvalds/linux
commit: 4d349ee5c7782f8b27f6cb550f112c5e26fff38d
kernel version: 7.0.0-rc1
hardware: QEMU Ubuntu 24.10
