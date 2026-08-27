Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7F3CDBAA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871923; cv=pass; b=FoYu3XmUGXSzZn/XEujqxDGjEDpwoOoDp7hHry7YezTp9vpt12snsiouW/y1yNhEpnsahUMlF/wrfCI9LJjX5zkjldcnmRZSeUU+uLSoCSUkrHYckYa89hQYW8AyqMFnsD+QwvIzacIf9fessjxdP0ZfOlC+omsi4oHWo1ndDpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871923; c=relaxed/simple;
	bh=T0RUxs5iUVohqOFWo7bsso96RXmZbMN1bhLYXJJYlQs=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=iv5zXwUsVtJ5m71KAsPcl9uVgWgyvEOPLRgINXjswwKlDkLxaxo4imFdGPW4tH2Gy/gDzHGni++75rti92T88c50fE0cUbBvzbJS75vBp0QNfx3jqfwHdTodEe50UXfVH4Bn9Q025toIvNiI7dtevWQpEtLb2dsn3+knNkwLWCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=XZoGQapS; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="XZoGQapS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1247783a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 16:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787871921; cv=none;
        d=google.com; s=arc-20260327;
        b=k+NSoC1UR6N3f1XC2k3EljA3IRlYBMMIauHQRY9317K+seWj9JX9zkzMg6PJZdYnvt
         whmhXJwgSEtQadeSLOa1ebwzf8yzie/3CAWMOMAdXGQEbWDmBEXao63Q9FSeKiD5M3hT
         I696Y8Q1CSB8xqLYXhKhJr/FhAs4f/YyexJ2aJofG3bLrgzBYMEZJ/v2D31AKI8jJdRF
         hd1Qj6YLabe7N75MSXOHiu0QO1YNsxHJaT7rnzaMlVY9dQ4sp98MWy9TND7Eulnz5ipF
         5qxF0HBOMzD0GEhNan7PAgakpjWduj65Suf2IwUgTh5M5BsqppUAZc64n2f1Ef3VeFTG
         7pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=X25WdoWGkB4WSbQ6LwAsBNMpG4cFx/LTnS4pR+o5vbU=;
        fh=68DCVnFwWtebIqxxOoxBsquWtcaNXQFtoZpxT0sK3t4=;
        b=QTbNWmz5+uacQxpw8lDMvoZswDmSGolG9XYP/m9QzNC/a2e6VNKCNhgPKgeZFH+g7Q
         pUafWfJe6/D69JYMaMl2dsh1JmRIjq6cuNncFNscvxBipXwC9zJYwGQ3E1/xgfQdMETn
         xd6cMK0AHHpRwQAlHjHSgAsQL8HNt9wenpStzNrItbGCFSpr78Kt16tK5SjWcDqd6kPH
         ZjNL2X7Dah+jab9JqPZuLz+hXiTM3dU7GG31GDMDWN7xE/dAf2oifzvUnx3DfNiZ7GTE
         54/xMDFQ6hB0tOX+xvcgxhZtT1xFnC9NLpHaq4SJHKuOo50Kf+ufTzoDtYZay3jp5DBc
         R1BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787871921; x=1788476721; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X25WdoWGkB4WSbQ6LwAsBNMpG4cFx/LTnS4pR+o5vbU=;
        b=XZoGQapSLBxHrhD0a/wydlgQffNSzJMSpdSnfCqMvcBXPzX9rTgnFgbbeyrSFtY3lq
         PoFX8uV2P+CEhCnwAO1CruJQUnusq4hPWDzrNwHJ/TPG9JsCO6CWFrsJAzl/0QHoh8yf
         GMO6CYnsVjI9we+y+nc+1BRQ9IEKL90RWB/A1feR60vmfrheJZWBM2OdpMQBCA1hjlxy
         oDLUwXqAm74/zYdCSpA0Ox5tV+PZpqntrHPenqZitCdUF6T1BEu3jV5j8pUBYO6/vpO2
         fQpjYopPNeRSp87cZZExPXxloTNRtWfihKabw6gwZSGIqZingCGwfT3hI2Vk8EwfOyRf
         8dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787871921; x=1788476721;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X25WdoWGkB4WSbQ6LwAsBNMpG4cFx/LTnS4pR+o5vbU=;
        b=a4Vk9ka+lUoa7NMcohwRHApe/nleu5Y13rzRfVG8+YaiVPEFExxsn5ZOgMpTRMRBtP
         4HRAt6L4aimkdGwbt1/dKlf1d3+2Fo7PLJQopTwM1/CoZaKhVjmTKMqAt0SHZ/kAVCOG
         gQNMIuDM+IGZm5jXALBykuxYfgE7dfCUaniUNeEyZB541JqA408CHvHmdrMRf0gEf1KA
         AbAnO8B1qAB20DPdz92NkWLeoxYUa0XcMDJzvZUD8OlK/j9VeuU1sVj5WZb20qIQOjQn
         wHO757jF+89JkgpRIAA8I51GjOicGlymIc8wLyUx02e9FojZGU0UUNGxTJj8QnU725Jr
         ELcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCV95RXOo8cj1sMSyq/85S7NwHhJgmFa9YhtluwlWiPUP6Pr/oPnH/w7wG+Rz66dN62E8j+b+o3YKjaaLvlfIqoKo=@vger.kernel.org
X-Gm-Message-State: AFuF++mb2q+aKCgJDc9XsENCni59hw+3t2xrIFE9iBH8HMgSKxjMyP5U
	+TfaOoQbUDbIzV9f7sXw7YiOLIOtrd/D59nO7kK/MqL4/mpNvONZObTIZzlhBJUUWNoC/b+dsNm
	IzdCJ3UoKfuraiHjxtYLgsLQnuUNd4r3csWgM+2KqygVrZ268SIhDJA==
X-Gm-Gg: AR+sD13t78xxabgHpXpH1iMoTfh+7qOJKtyvWANMCJZdqA4Y/dXSmRcmhte8Tk+0uV8
	XhT1ZalLyjhg8tj6CkrI2l5ruclnEfZ3qXUm4PmmPu6l4Mnf3j3hn2QVWOoqspOcCESZnVJraJc
	XqRb6wqfk/IYaO+6DfA3hctZG77dsjH2hxfL/qkEINjVpKDVcsBoUwqi3zdgU2jrBw5IyEbLIQj
	vF25HPlYP8QmsBcGiD+JxWPIZsAN6kjCTtGUN7ZD4bjIEkYsOXBJyNZ46ZRjHVZl5GQuGkphK01
	R4tSs4Cs9dRAO0Wk94rRvxKxrQrL7OViIHQ8K78UfjHPSmQXMokm9+VP9vYVRXEc2q9fpvR3Hk7
	8yj/gSXwAvqoy/0G6QmesOTnKEIzOOR1C
X-Received: by 2002:a17:90b:2c88:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-396d0f2181amr2746723a91.7.1787871920400; Thu, 27 Aug 2026
 16:05:20 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 23:05:19 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 23:05:19 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 23:05:19 +0000
X-Gm-Features: AcwNN1U2yz4g3RBqqD2LAORwB7-8ngn-g7PZ_O0yjvAvyo7vWBiPT0oNGxQNvm0
Message-ID: <CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com>
Subject: [BUG] tracing: use-after-free in t_start() when a trace instance is removed
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: falemi@asu.edu, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Steven Rostedt, Masami Hiramatsu,

While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
SEFCOM lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/116-tracing-uaf-t_start-instance-rmdir/

  ==================================================================
  BUG: KASAN: slab-use-after-free in t_next
kernel/trace/trace_events.c:1568 [inline]
  BUG: KASAN: slab-use-after-free in t_start+0xcc/0x210
kernel/trace/trace_events.c:1592
  Read of size 8 at addr ffff888022f7a960 by task syz.4.116/12466
  CPU: 0 UID: 0 PID: 12466 Comm: syz.4.116 Not tainted 7.1.0-rc5 #1
PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
  Call Trace:
  <TASK>
  dump_stack_lvl+0x94/0xd0 lib/dump_stack.c:120

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
