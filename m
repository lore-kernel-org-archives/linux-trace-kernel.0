Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B41D9A79
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247012; cv=none; b=o5EI9MS9XeNxeBWjB9Ml7QSJxW6GYWO5kVg+7RpCMDjkbr2mlELdOo6B0HjOBRdSiYl5zXnjjZT01o1AbTeurfGZDQ1cG7q2nY0zqAkXSSYooB+OfJohAHkb2ExTvEcPqjK85/TJSzp9DkxXFhyKbZ60RIwEwmqgD1oomCufFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247012; c=relaxed/simple;
	bh=Pi5NlVNm/rltwm6mYcylZqOiE1Fe/3aCEI2yFGKYAWM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LaQWCrjV6HE9VeNXuuSqQRq0y0B1cQco/wUb+Zat55kOc9qNg4SHZT5YeOfcmdijZCmLKz5/ZJ9BPprzEFfxEyxyVu9E6KfTmCJTshfR/aJd0VdClWjFzvAQwA97OjYIVtycChWMNpl+aGaKevZussFjNoj8DnXc/qysTpF2yFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KjyRzcC+; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjyRzcC+"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523a00c9d96so142973e0c.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Mar 2025 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741247008; x=1741851808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f8Dvz/7sO8hMEWomCti/xqwSI3nDVRwoSfwLBCt5iKs=;
        b=KjyRzcC+jjkjjZ0LioBHd8k8x7nO6H4M+Iy7Zma+Z2mdkbSh/3gJr55cewaq5vSKvE
         vDRp8tE0rvEukjPD8jokBkraOl9AjInQ4WIrCWK0c53CMpFvuJtpJKRRdfYu9eDceD8j
         +T69nJfbJgejAtK/Mlx/ClLfveo+0+CEEfunCZmRcC72XAS65csYF0jS22rzdmrnL55h
         6h/VoOf42NUlYCs+ki5vGPWpNJwl0MdtpnABe9BaMJED/LDQkaHwMVrOEVtchw/O57T7
         Y7unvusI/uhwvialXbXTpNtxjQuTBJJk0puHei0330VH5KVCiaMlAlFrkpg3e3TUqYOX
         nQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247008; x=1741851808;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8Dvz/7sO8hMEWomCti/xqwSI3nDVRwoSfwLBCt5iKs=;
        b=RjtAWDGj7zryavp4HPxerTKyDMuiDA1F4o4+cBkcacYkz0jnRcsXXmAFo1y+qBfmny
         3zMQCAAECnaT9iTCKt/kXSJL4PQR297DPu6ntTszQPTFfny15J0gfX+GBWAtoVj/mQPM
         X4TMiuTz3nHYKSwQ8jAsHJgXkmKYIF2L+tlk9YdJI0GlOV+akcTG2ZbQuRUaVR1J/cxJ
         kXjOVzN+xFacRs5MiS0s/x7fVLapyR1Wse9cRySiKcYt+Ej5Gi8Itjmgll8Ekbh/7smo
         IMxPNyZ0ddWdPELWC3wLZ0I97ZGW9HZDIfPQHAr+OdznsfoQKQMkRoOqqzPXTV8+pcsA
         WSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2VpdIIaZ5tEZuLSkCa9hYcH9fjc33nfOJevSlW16K77Holfgtui0pYjF3HJfEha9C55qSIPzY3P6csemhGSo9Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9f32tJs/H/H3HaFif6snoY7bBZ5Eq8KVxWIoMTSex2zm4m6c
	F+NuDp4gDnlWU+/myui9oQb3lhrwT7FhYo8LJ6OALjNC59cBCidh8XuVvBAs5jaGdSjnLRfW3P2
	r0PO/Tf2NXqfG+esMzerwGcgISrMEZ4L4KLNK9g==
X-Gm-Gg: ASbGnctYL6IOpc45LpYJlqwQ6ODNIRPl/siSSy3Le3JzPAY0ioZHLcDtcTIRYNcKFWq
	qc7O6irhbOpttI4ZZC41CXg8At5oe/pnV1Oa3a+hTNbB9bMehiSyifaTIOSco0ScHCMtTN9LgHL
	3Iae1BdshLgK97CsV6rULkba3f2Kz3XJA5umXCHMFDizhhcdeDBWCRnkePCps=
X-Google-Smtp-Source: AGHT+IFCeuFwk9j8vSJUY4VHl93BKrc/RzqL6Bv4GsNnLvaSOuMd4a+uHqaFLvjJ1SRrJcOoTcInKFZtooGmILaXwuQ=
X-Received: by 2002:a05:6102:ccc:b0:4c1:706f:92a1 with SMTP id
 ada2fe7eead31-4c2e276618bmr3018833137.5.1741247008163; Wed, 05 Mar 2025
 23:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 13:13:17 +0530
X-Gm-Features: AQ5f1Jq0IuOElt6LkapirWtEVl2Mi3VZsosq658XD0TPtmeB7_YSwPygLW3yIlU
Message-ID: <CA+G9fYvp_oAxeDFj88Tk2rfEZ7jtYKAKSwfYS66=57Db9TBdyA@mail.gmail.com>
Subject: riscv: WARNING: kernel/trace/fgraph.c:755 ftrace_return_to_handler
To: linux-riscv <linux-riscv@lists.infradead.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, alex@ghiti.fr, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On riscv while running LTP tracing ftrace_stress_test.sh the
Bad frame pointer, kernel warning and kernel panic noticed.

## Devices Affected:
The following DUTs / qemus experience these failures:
  -  qemu-riscv

Regression Analysis:
 - New regression? No (these failures have been observed for months/years).
 - Reproducibility? Yes, the failures occur consistently more than 80%

Test regression: ftrace_stress_test.sh Bad frame pointer kernel panic
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log:
command: ftrace_stress_test.sh 90
<12>[   49.329931] /usr/local/bin/kirk[266]: starting test
ftrace-stress-test (ftrace_stress_test.sh 90)
ftrace-stress-test 1 TINFO: Ftrace Stress Test Begin
ftrace-stress-test 1 TINFO: Test targets:  trace_pipe current_tracer
ftrace_enabled function_profile_enabled set_event set_ftrace_pid
stack_max_size stack_trace trace trace_clock trace_options trace_stat
tracing_enabled tracing_max_latency tracing_on
function_profile_enabled buffer_size_kb tracing_cpumask
set_ftrace_filter
ftrace-stress-test 1 TINFO: tracing_enabled is not supported. Skip it.
ftrace-stress-test 1 TINFO: Start pid0=301
/opt/ltp/testcases/bin/ftrace_stress/ftrace_trace_pipe.sh
ftrace-stress-test 1 TINFO: Start pid1=302
/opt/ltp/testcases/bin/ftrace_stress/ftrace_current_tracer.sh
ftrace-stress-test 1 TINFO: Start pid2=303
/opt/ltp/testcases/bin/ftrace_stress/ftrace_ftrace_enabled.sh
trap: SIGUSR1: bad trap
ftrace-stress-test 1 TINFO: Start pid3=306
/opt/ltp/testcases/bin/ftrace_stress/ftrace_function_profile_enabled.sh
ftrace-stress-test 1 TINFO: Start pid4=307
/opt/ltp/testcases/bin/ftrace_stress/ftrace_set_event.sh
ftrace-stress-test 1 TINFO: Start pid5=309
/opt/ltp/testcases/bin/ftrace_stress/ftrace_set_ftrace_pid.sh
<4>[   51.266264] ------------[ cut here ]------------
<4>[   51.266294] ------------[ cut here ]------------
<4>[   51.268785] Bad frame pointer: expected ff200000005f2d10,
received ffffffff815e3a18
<4>[   51.268785]   from func __might_sleep return to ffffffff8004c380
<4>[   51.267055] Bad frame pointer: expected ff20000000662ed0,
received ffffffff80081bce
<4>[   51.267055]   from func cpus_read_lock return to ffffffff8021bfda
<4>[ 51.273594] WARNING: CPU: 0 PID: 306 at kernel/trace/fgraph.c:755
ftrace_return_to_handler (kernel/trace/fgraph.c:755 (discriminator 1)
kernel/trace/fgraph.c:820 (discriminator 1) kernel/trace/fgraph.c:874
(discriminator 1))
<4>[ 51.273624] WARNING: CPU: 1 PID: 309 at kernel/trace/fgraph.c:755
ftrace_return_to_handler (kernel/trace/fgraph.c:755 (discriminator 1)
kernel/trace/fgraph.c:820 (discriminator 1) kernel/trace/fgraph.c:874
(discriminator 1))
<4>[   51.273856] Modules linked in:
<4>[   51.273888] Modules linked in: drm drm_panel_orientation_quirks configfs
<4>[   51.274071]  drm
<4>[   51.274234]  backlight ip_tables
<4>[   51.274236]  drm_panel_orientation_quirks configfs
<4>[   51.274285]  x_tables
<4>[   51.274306]  backlight
<4>[   51.274328]
<4>[   51.274331]  ip_tables
<4>[   51.274351]  x_tables
<4>[   51.274758] CPU: 1 UID: 0 PID: 309 Comm: sh Not tainted
6.14.0-rc5-next-20250305 #1
<4>[   51.274817] CPU: 0 UID: 0 PID: 306 Comm: sh Not tainted
6.14.0-rc5-next-20250305 #1
<4>[   51.274954] Hardware name: riscv-virtio,qemu (DT)
<4>[   51.275009] Hardware name: riscv-virtio,qemu (DT)
<4>[ 51.275231] epc : ftrace_return_to_handler
(kernel/trace/fgraph.c:755 (discriminator 1) kernel/trace/fgraph.c:820
(discriminator 1) kernel/trace/fgraph.c:874 (discriminator 1))
<4>[ 51.275224] epc : ftrace_return_to_handler
(kernel/trace/fgraph.c:755 (discriminator 1) kernel/trace/fgraph.c:820
(discriminator 1) kernel/trace/fgraph.c:874 (discriminator 1))
<4>[ 51.275291] ra : ftrace_return_to_handler
(kernel/trace/fgraph.c:755 (discriminator 1) kernel/trace/fgraph.c:820
(discriminator 1) kernel/trace/fgraph.c:874 (discriminator 1))
<4>[ 51.275304] ra : ftrace_return_to_handler
(kernel/trace/fgraph.c:755 (discriminator 1) kernel/trace/fgraph.c:820
(discriminator 1) kernel/trace/fgraph.c:874 (discriminator 1))
<4>[   51.275374] epc : ffffffff8016e9ee ra : ffffffff8016e9ee sp :
ff200000005f2c30
<4>[   51.275393] epc : ffffffff8016e9ee ra : ffffffff8016e9ee sp :
ff20000000662de0
<4>[   51.275418]  gp : ffffffff81c70828 tp : ff60000080a45700 t0 :
ffffffff800b84c2
<4>[   51.275422]  gp : ffffffff81c70828 tp : ff60000082b0ab80 t0 :
ffffffff800b84c2
<4>[   51.275460]  t1 : 0000000000000000 t2 : 20636e7566206d6f s0 :
ff200000005f2cb0
<4>[   51.275474]  t1 : 0000000000000000 t2 : 20636e7566206d6f s0 :
ff20000000662e60
<4>[   51.275504]  s1 : 00000000000001dd a0 : 000000000000007c a1 :
0000000000000001
<4>[   51.275518]  s1 : 00000000000001dd a0 : 000000000000007d a1 :
0000000000000001
<4>[   51.275545]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
0000000000000000
<4>[   51.275547]  a2 : 00000000000000e8 a3 : 0000000000000008 a4 :
0000000000000000
<4>[   51.275587]  a5 : 0000000000000000 a6 : 000000000000003f a7 :
0000000000000010
<4>[   51.275615]  a5 : 0000000000000000 a6 : 0000000000000030 a7 :
0000000000000010
<4>[   51.275654]  s2 : ff60000086e43ee8 s3 : ffffffff815e3a18 s4 :
ffffffff815e6728
<4>[   51.275684]  s2 : ff60000086e46ee8 s3 : ffffffff80081bce s4 :
ffffffff815e6728
<4>[   51.275700]  s5 : 0000000000000000 s6 : 0000000000000000 s7 :
ffffffff81c70160
<4>[   51.275715]  s5 : 0000000000000000 s6 : 0000000000000000 s7 :
ffffffff81c70160
<4>[   51.275743]  s8 : 00005555822950b0 s9 : ffffffffffffc000 s10:
ffffffff80d5100a
<4>[   51.275758]  s8 : 0000000000000003 s9 : ffffffffffffc000 s10:
ffffffff80d5100a
<4>[   51.275786]  s11: ff200000005f3aa0 t3 : 0000000000000000 t4 :
0000000000ff0100
<4>[   51.275786]  s11: ff20000000663d60 t3 : 0000000000000000 t4 :
0000000000ff0100
<4>[   51.275826]  t5 : ffffffff81c87c38 t6 : ffffffff81c87c34
<4>[   51.275842]  t5 : ffffffff81c87c38 t6 : ff20000000662be8
<4>[   51.275867] status: 0000000200000100 badaddr: ffffffff8016e9ee
cause: 0000000000000003
<4>[   51.275868] status: 0000000200000100 badaddr: ffffffff8016e9ee
cause: 0000000000000003
<4>[ 51.275996] ftrace_return_to_handler (kernel/trace/fgraph.c:755
(discriminator 1) kernel/trace/fgraph.c:820 (discriminator 1)
kernel/trace/fgraph.c:874 (discriminator 1))
<4>[ 51.276009] ftrace_return_to_handler (kernel/trace/fgraph.c:755
(discriminator 1) kernel/trace/fgraph.c:820 (discriminator 1)
kernel/trace/fgraph.c:874 (discriminator 1))
<4>[ 51.276157] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.276164] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.276348] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276357] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276408] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276454] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.276500] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276545] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.276571] ---[ end trace 0000000000000000 ]---
<4>[ 51.276590] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276645] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276689] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.276733] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276779] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276824] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276869] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.276914] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.276959] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277004] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277049] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277094] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277139] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.277181] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277222] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.277238] ------------[ cut here ]------------
<4>[ 51.277268] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277274] WARNING: CPU: 0 PID: 306 at kernel/trace/fgraph.c:824
ftrace_return_to_handler (kernel/trace/fgraph.c:824 (discriminator 1)
kernel/trace/fgraph.c:874 (discriminator 1))
<4>[ 51.277314] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.277331] Modules linked in: drm drm_panel_orientation_quirks
<4>[ 51.277362] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[   51.277395]  configfs backlight
<4>[ 51.277409] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.277437]  ip_tables x_tables
<4>[ 51.277455] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.277472]
<4>[ 51.277505] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277550] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277595] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.277659] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277705] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277751] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.277770] CPU: 0 UID: 0 PID: 306 Comm: sh Tainted: G        W
        6.14.0-rc5-next-20250305 #1
<4>[ 51.277795] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277840] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.277885] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.277895] Tainted: [W]=WARN
<4>[   51.277923] Hardware name: riscv-virtio,qemu (DT)
<4>[ 51.277932] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277947] epc : ftrace_return_to_handler
(kernel/trace/fgraph.c:824 (discriminator 1) kernel/trace/fgraph.c:874
(discriminator 1))
<4>[ 51.277977] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.277993] ra : ftrace_return_to_handler
(kernel/trace/fgraph.c:824 (discriminator 1) kernel/trace/fgraph.c:874
(discriminator 1))
<4>[ 51.278024] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.278037] epc : ffffffff8016e862 ra : ffffffff8016e862 sp :
ff200000005f2c30
<4>[   51.278063]  gp : ffffffff81c70828 tp : ff60000080a45700 t0 :
ffffffff8004c3fe
<4>[ 51.278070] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[   51.278090]  t1 : 0000000000000000 t2 : 20636e7566206d6f s0 :
ff200000005f2cb0
<4>[   51.278118]  s1 : 00000000000001dd a0 : ffffffff81cb4998 a1 :
0000000000000031
<4>[ 51.278116] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.278144]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
0000000000000000
<4>[   51.278170]  a5 : 0000000000000000 a6 : 0000000000000030 a7 :
0000000000000010
<4>[ 51.278162] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.278196]  s2 : ff60000086e43e10 s3 : ffffffff815e3a18 s4 :
ffffffff815e6728
<4>[ 51.278209] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.278222]  s5 : 0000000000000000 s6 : 0000000000000000 s7 :
ffffffff81c70160
<4>[   51.278248]  s8 : 00005555822950b0 s9 : ffffffffffffc000 s10:
ffffffff80d5100a
<4>[ 51.278256] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.278274]  s11: ff200000005f3aa0 t3 : 0000000000000000 t4 :
0000000000ff0100
<4>[   51.278301]  t5 : ffffffff81c87c38 t6 : ffffffff81c87c34
<4>[ 51.278305] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[   51.278325] status: 0000000200000100 badaddr: ffffffff8016e862
cause: 0000000000000003
<4>[ 51.278351] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.278354] ftrace_return_to_handler (kernel/trace/fgraph.c:824
(discriminator 1) kernel/trace/fgraph.c:874 (discriminator 1))
<4>[ 51.278397] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.278402] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.278444] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.278450] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.278492] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[   51.278503] ---[ end trace 0000000000000000 ]---
<4>[ 51.278537] return_to_handler (arch/riscv/kernel/mcount.S:78)
<4>[ 51.278584] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.278642] return_to_handler (arch/riscv/kernel/mcount.S:75)
<4>[ 51.278686] return_to_handler (arch/riscv/kernel/mcount.S:75)
<0>[   51.278907] Kernel panic - not syncing: include/linux/percpu-rwsem.h
<4>[   51.350558] CPU: 0 UID: 0 PID: 306 Comm: sh Tainted: G        W
        6.14.0-rc5-next-20250305 #1
<4>[   51.351855] Tainted: [W]=WARN
<4>[   51.352213] Hardware name: riscv-virtio,qemu (DT)
<4>[   51.353333] Call Trace:
<4>[ 51.353947] dump_backtrace (arch/riscv/kernel/stacktrace.c:133)
<4>[ 51.354543] show_stack (arch/riscv/kernel/stacktrace.c:139)
<4>[ 51.355094] dump_stack_lvl (lib/dump_stack.c:122)
<4>[ 51.356791] dump_stack (lib/dump_stack.c:130)
<4>[ 51.358139] panic (kernel/panic.c:258 kernel/panic.c:375)
<4>[ 51.359243] return_to_handler (??:?)
<2>[   51.360158] SMP: stopping secondary CPUs
<4>[   53.526474] SMP: failed to stop secondary CPUs 0-1
<0>[   53.528165] ---[ end Kernel panic - not syncing:
include/linux/percpu-rwsem.h ]---

## Source
* Kernel version: 6.14.0-rc5-next-20250305
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
* Git describe: 6.14.0-rc5-next-20250305
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250305/
* Architectures: riscv

## Test data
* Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250305/testrun/27501921/suite/log-parser-test/test/exception-cut-here/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250305/testrun/27501921/suite/log-parser-test/test/panic-multiline-kernel-panic-not-syncing-includelinuxpercpu-rwsemh/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250305/testrun/27501921/suite/log-parser-test/test/exception-cut-here/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ttVEZncyQq7CkHBSKLG3bD6Ajk/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ttVEZncyQq7CkHBSKLG3bD6Ajk/config


--
Linaro LKFT
https://lkft.linaro.org
