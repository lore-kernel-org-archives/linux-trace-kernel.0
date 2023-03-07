Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC8C678DB
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  7 Mar 2023 10:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCGKFc (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 7 Mar 2023 05:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCGKF1 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:05:27 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1162B5F
        for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:05:13 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id m5so8436059uae.11
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678183512;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJQteWRnYzXph7B/Yag6wboM2N2GJr+YfQg8dgWg9fg=;
        b=i8YkSnXonegkW6NuzrPQBnddeL5AYYykbpX7rf6mfB8qYXCajrksSX8+6x4H5APR+w
         CyNC62BEdd3IYiqGt744W8UizLpcEOdhUiDZRYh/JcwTFH6rlLqr7g9s07erwqZcY7dp
         q/F4VRUtobYOSrlJ7QIQWS6hZAgJzvST7krsB060SCJMGqiX21BS0uo1RLBt3V0qA+Cf
         WT23cEsgXMPi/eZrq57WQU3qNvc/9+1vGZmbtzjWxUWi/VDuq4oxgV+Sg408FcGFZxpi
         ft4GnPZVeN7MdoezfV5rJKQ0+V0oxD6qCplcauC3YCrpheLCf/aDfQi/OCF/2Gopx5U0
         RQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183512;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJQteWRnYzXph7B/Yag6wboM2N2GJr+YfQg8dgWg9fg=;
        b=I24zwvSWe8/mTzWDSI9d3oHwUbe51ulP73aRTTqi4+MaF+NlbExPMQQOd9BwbOEFry
         PYSehJxKpGFXJc2Vig1FKm3SuKq5/U9WeXgBF1rXEkNXxvgxQpIHywoSQzaSpbj3Q8/0
         vpm9BK7pATSYZ3X8UySS6n//l/vicVxF5PeJQVDLkD0pn+i24VMD/J/zPYdRGS+3zn2c
         egmLMo8uarpWKg8qaAGrWXhD90loFhFwJ8kjBBh0hZyD0Sf1W2QZaEgDx9hvY6RacWBW
         +P/NdxsaJya5QeyPYnIpaMlvHx9DUAxhagAKJEs/dlf0qJ1pJIycwNDCTpK0HZdaOBmJ
         uYiw==
X-Gm-Message-State: AO0yUKUGH8dTDgrDb9DHflXN9KzcI6jaNlGJp6Fz5QNsIDGnNSClVeeu
        TDibvwevkjMYnGwLvOlW1B9StgrRVyqsVegIf1kzgg==
X-Google-Smtp-Source: AK7set8c+gLtppl3OV34UlpT2NVSBrBDOXjbBL6Qoi5a7s9uQCdvDonXutxUCPmrYcSLhl/Eg4gal+XbsMwFV15tygk=
X-Received: by 2002:a1f:e483:0:b0:406:3e8d:92c8 with SMTP id
 b125-20020a1fe483000000b004063e8d92c8mr8898453vkh.1.1678183512529; Tue, 07
 Mar 2023 02:05:12 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Mar 2023 15:35:01 +0530
Message-ID: <CA+G9fYuJJySMY_6oLx_R_ebX9wDkwTLbDW7f7_CqF9UgFhSajg@mail.gmail.com>
Subject: ftrace_regression01: qemu-i386: EIP: vm_area_free: Kernel panic - not
 syncing: Fatal exception in interrupt
To:     linux-clk <linux-clk@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-trace-kernel@vger.kernel.org,
        LTP List <ltp@lists.linux.it>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The following kernel panic noticed While running LTP tracing tests on
qemu-i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


[    0.000000] Linux version 6.3.0-rc1 (tuxmake@tuxmake) (Debian clang
version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
Debian LLD 16.0.0) #1 SMP PREEMPT_DYNAMIC @1678136838
...
LTP tracing tests
Running tests.......
<6>[   35.957375] traps: systemd-network[287] trap invalid opcode
ip:b7d99bef sp:bfcf8e20 error:0 in
libsystemd-shared-250.so[b7c33000+1c0000]
<6>[   39.887678] traps: systemd-network[330] trap invalid opcode
ip:b7db0bef sp:bfb6ab00 error:0 in
libsystemd-shared-250.so[b7c4a000+1c0000]
<4>[   41.883172] clocksource: timekeeping watchdog on CPU0: Marking
clocksource 'tsc' as unstable because the skew is too large:
<4>[   41.885195] clocksource:                       'acpi_pm'
wd_nsec: 633206175 wd_now: 13fe92 wd_last: f168b4 mask: ffffff
<4>[   41.886363] clocksource:                       'tsc' cs_nsec:
5320282620 cs_now: 1cbab6bece cs_last: 19231a48ea mask:
ffffffffffffffff
<4>[   41.887503] clocksource:                       Clocksource 'tsc'
skewed 4687076445 ns (4687 ms) over watchdog 'acpi_pm' interval of
633206175 ns (633 ms)
<4>[   41.888583] clocksource:                       'tsc' is current
clocksource.
<6>[   41.889615] tsc: Marking TSC unstable due to clocksource watchdog
<4>[   41.894933] TSC found unstable after boot, most likely due to
broken BIOS. Use 'tsc=unstable'.
<6>[   41.895623] sched_clock: Marking unstable (41348265135,
546543322)<-(41919545028, -24729054)
<4>[   41.905093] clocksource: Checking clocksource tsc
synchronization from CPU 1 to CPUs 0.
<6>[   41.921496] clocksource: Switched to clocksource acpi_pm
<47>[   42.122074] systemd-journald[108]: Successfully sent stream
file descriptor to service manager.

ftrace_regression01 1 TPASS: Finished running the test

<4>[   43.795642] int3: 0000 [#1] PREEMPT SMP
<4>[   43.795642] CPU: 0 PID: 331 Comm: systemd-network Not tainted 6.3.0-rc1 #1
<4>[   43.795642] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[   43.795642] EIP: vm_area_free+0x1/0x20
<4>[   43.795642] Code: e5 85 1d 00 85 c0 74 14 b9 11 00 00 00 89 c7
f3 a5 89 c1 83 c1 24 89 48 24 89 48 28 5e 5f 5d c3 90 90 90 90 90 90
90 90 90 3e <8d> 74 26 00 55 89 e5 89 c2 a1 ac 99 82 d3 e8 fc 8f 1d 00
5d c3 90
<4>[   43.795642] EAX: c243bab0 EBX: c243bab0 ECX: 00000000 EDX: c23cb9c0
<4>[   43.795642] ESI: 00000000 EDI: 000001c0 EBP: c25c1e24 ESP: c25c1dd0
<4>[   43.795642] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000246
<4>[   43.795642] CR0: 80050033 CR2: 081d764c CR3: 02ce1000 CR4: 000006d0
<4>[   43.795642] Call Trace:
<4>[   43.795642]  ? do_vmi_align_munmap+0x26e/0x380
<4>[   43.795642]  mmap_region+0x26e/0x880
<4>[   43.795642]  ? arch_ftrace_ops_list_func+0x20/0x1a0
<4>[   43.795642]  ? ftrace_call+0x5/0x13
<4>[   43.795642]  do_mmap+0x33f/0x4b0
<4>[   43.795642]  ? do_mmap+0x3f6/0x4b0
<4>[   43.795642]  vm_mmap_pgoff+0x9b/0x120
<4>[   43.795642]  ksys_mmap_pgoff+0x15d/0x1b0
<4>[   43.795642]  __ia32_sys_mmap_pgoff+0x21/0x30
<4>[   43.795642]  do_int80_syscall_32+0x39/0x74
<4>[   43.795642]  entry_INT80_32+0xf0/0xf0
<4>[   43.795642] EIP: 0xb7f7d9c1
<4>[   43.795642] Code: c3 8d b4 26 00 00 00 00 90 8b 5c 24 08 01 c3
8b 6c 2b 40 89 2f eb b6 66 90 f3 0f 1e fb 53 57 55 8b 1f 8b 6f 08 8b
7f 04 cd 80 <5d> 5f 5b c3 66 90 66 90 66 90 66 90 66 90 90 f3 0f 1e fb
e8 5a 00
<4>[   43.795642] EAX: ffffffda EBX: b7c94000 ECX: 001c0000 EDX: 00000005
<4>[   43.795642] ESI: 00000812 EDI: 00000004 EBP: 0000003b ESP: bff393e0
<4>[   43.795642] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000202
<4>[   43.795642] Modules linked in:
<4>[   43.795642]  \
 ---[ end trace 0000000000000000 ]---
<4>[   43.795642] EIP: vm_area_free+0x1/0x20
<4>[   43.795642] Code: e5 85 1d 00 85 c0 74 14 b9 11 00 00 00 89 c7
f3 a5 89 c1 83 c1 24 89 48 24 89 48 28 5e 5f 5d c3 90 90 90 90 90 90
90 90 90 3e <8d> 74 26 00 55 89 e5 89 c2 a1 ac 99 82 d3 e8 fc 8f 1d 00
5d c3 90
<4>[   43.795642] EAX: c243bab0 EBX: c243bab0 ECX: 00000000 EDX: c23cb9c0
<4>[   43.795642] ESI: 00000000 EDI: 000001c0 EBP: c25c1e24 ESP: c25c1dd0
<4>[   43.795642] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000246
<4>[   43.795642] CR0: 80050033 CR2: 081d764c CR3: 02ce1000 CR4: 000006d0
<0>[   43.795642] Kernel panic - not syncing: Fatal exception in interrupt
<0>[   43.795642] Kernel Offset: disabled

test log:
-----
  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc1-2-g8ca09d5fa354/testrun/15298979/suite/log-parser-test/test/check-kernel-panic/log
  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc1-2-g8ca09d5fa354/testrun/15298979/suite/log-parser-test/tests/


steps to reproduce:
--------------
# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.37.2
#
# See https://tuxrun.org/ for complete documentation.

tuxrun  \
 --runtime podman  \
 --device qemu-i386  \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2MemUurDShqDi3xoAvTknd2dbfd/bzImage
 \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2MemUurDShqDi3xoAvTknd2dbfd/modules.tar.xz
 \
 --rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2MV9clY6B5uyK3SNAIPgiO5gCoP/images/intel-core2-32/lkft-tux-image-intel-core2-32-20230303113918.rootfs.ext4.gz
 \
 --parameters SKIPFILE=skipfile-lkft.yaml  \
 --parameters SHARD_NUMBER=4  \
 --parameters SHARD_INDEX=1  \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f  \
 --tests ltp-tracing  \
 --timeouts boot=15 ltp-tracing=30


--
Linaro LKFT
https://lkft.linaro.org
