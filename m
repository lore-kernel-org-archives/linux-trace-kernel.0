Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CC329C6B;
	Fri,  8 May 2026 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248516; cv=none; b=hF8WPhsPirKyFuB12cHb5J7dY6Jl2SnjBD6dJ4FM2AOvERHRE9P5OgI6oibfBiOzycO3YLmRfU65aB08fC3S5wkMQNLOilt09I9edwaijCR71Lir9w/dxC0Tmg1jvJInnr8PIm5GqRFF5tKtpTZYa8TWGK5/G90Tw51WlzHHpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248516; c=relaxed/simple;
	bh=9a+I85bQwies79X8PAu940AVw7wrJrvOUZhYk7nkGLo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D9CzFZ7RVxVKBO0AMez7iY1mhEunkTWovBmN/n9hDPDeM17Iipi0YqzuceeffwA0ecSrs6N37AcO9YVosys/T+r/hu3QnbMwjAL+QrLiDxW/Ze9s8qtCj7BD7Moewj2djlveRF9uBj/jtSc5Xj6/rfGO+kH+HbkHpZbXxQP9xoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=k9XboejP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="k9XboejP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=svi5dy1bN8Y21l/5zPkOPhEITWrtVBy7MJjMiXiK/d4=; b=k9XboejPyzNSDkRTD/FZ91hIUq
	iC1ncynW7G9zXARWsBaN45qKiDzXDk+Ht82vr8s25nuOjg63NKkv6rhA1/MSgSDanyFD6cb41eKxI
	DXVE/OHw9NVmJGw7oE56etXIHWlvx8JxlJt7ZZyFa+UTxPUejhHnH30DyNQdCAq9dnU3FLhOVuLo2
	ImHqRe+o6gmHH155/A9sCtcelRmzQvn/ZwF19FM4frNiTF6bFGVvs0MJfId5hmjpGgq4qfe8FRIk4
	ybpg4LkMq5J/r8XFeqNWJrwJXgm4OkVTW/439xhYIBPGniO5XD2gWVNb619b82SrTsqf9LcHjIFUy
	b0NDcO+g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLfa-005BwB-0g;
	Fri, 08 May 2026 13:55:10 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] tools/bootconfig: render kernel.* subtree as a cmdline
 string
Date: Fri, 08 May 2026 06:55:02 -0700
Message-Id: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADfr/WkC/yXMUQrCMAwA0KuEfK9QB5vaq4iMrEtrRBppOhHG7
 i7q5/t5GxpXYcMAG1Z+iYkWDHDoAOONSmYnCwbA3vejH/zJzaotakmSp9Wk5KmpPszFREei8zL
 SQNgBPisnef/iy/VvW+c7x/bdcN8/cFUgYHoAAAA=
X-Change-ID: 20260508-bootconfig_using_tools-cfa7aa9d6a5a
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 paulmck@kernel.org, oss@malat.biz, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4150; i=leitao@debian.org;
 h=from:subject:message-id; bh=9a+I85bQwies79X8PAu940AVw7wrJrvOUZhYk7nkGLo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/es6PpyeImJ3ELueExedNY92qIydtEPnW6NAe
 Si/qbFnN3GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3rOgAKCRA1o5Of/Hh3
 bQ2WD/4jiWEhe0TdcgfkufnVisOmW8A2ERj7Sac/xhLeyTX9zDmB0j554x6ATVV2Ev2zPRYD5w0
 B6nFPOs3ZcuQBsyDvxYCWXCviXGC7b8QEvUOe3ftaez6Sd0/gg+VnZZNGurrP4f//LBESb5fH2j
 SZ20YVjE29B1IEnxLzEgbGjKQmhLWdcZAX/c2Mx0TE6yzmObq2v4wvKJvs3KKRkadTjHTE4D5lu
 EcNLWyGzPy6MY7W6F89ZV0ykMUxxR0x+zjGPVIUrZZcF1hPMEwbhsLsfdJ3U1f6D2Mzuvu5jpuM
 O0OR6qWmS/65uMw9cNZ///KyFVMrYHWWhT2g95EQuLma/LRV8C1lt6fl6il0wOqKVt4tlTEGPcG
 7jhRQsAioMZZzM3aabdGznJB241umeKmz/vBkZVBQk7oTZUZWPDcnMDWsyicrXOT0JRaI2NYo2U
 v6R9kCsayvOHxDffD1/gw7gRvOA2aiaJ1bzYXgeZAfrLqCI88GR+oihcuraTFt+R5d+cVd1nj8m
 iaUWx4KyV9Yx1gIA4VfZ0c7ym9W9SDY3YRlAJi409tF4wBiODAoea+mSpCxnRWEch723QQ+1v4V
 wnbH9Mg9neSNExpQahyv1t2kawcD1TuqCN0sNm4ZdpDrHe4GvHjajHxSPcqu3Ei3nU4y1xO7jzt
 2/b+ErTWuUquA9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a bootconfig -> kernel cmdline rendering capability shared between
the kernel parser library and the userspace tools/bootconfig binary.

The new userspace mode "tools/bootconfig -C <file>" walks a bootconfig
file's "kernel" subtree and prints it as a flat, space-separated
cmdline string suitable for direct use as (or appending to) a kernel
command line.

This series prepares tools/bootconfig and lib/bootconfig.c for an
upcoming feature that lets the kernel build render an embedded
bootconfig file's "kernel" subtree to a flat cmdline string and embed
it in the kernel image.

The follow-up series (sent separately) wires this into setup_arch() so
early_param() handlers see values supplied via CONFIG_BOOT_CONFIG_EMBED_FILE,
following Masami suggestion in [1]

These two patches are pure groundwork. They add no kernel feature,
change no runtime behavior, and are useful on their own (the new
"tools/bootconfig -C" mode lets anyone render a .bootconfig file to
a cmdline string from the shell).

Landing them independently lets the follow-up series focus on the
kernel-side plumbing without dragging the refactor and tool addition
through the same review cycle.

Patch 1 lifts xbc_snprint_cmdline() from init/main.c into
lib/bootconfig.c so both the kernel runtime path
(xbc_make_cmdline -> extra_command_line) and the userspace tool can
share a single renderer. 
 - tools/bootconfig already compiles lib/bootconfig.c directly, so no
   new shared-code mechanism is introduced.

Patch 2 adds a -C option to tools/bootconfig that walks the "kernel"
subtree of a bootconfig file and prints it as a flat, space-separated
cmdline string. Missing or empty kernel.* produces empty output and
exits 0.
 - This is the renderer the kernel build will invoke.

Once this lands, the follow up patches will use it in the following way:

1) Render at build time.
The kernel build invokes the userspace bootconfig tool — using the -C mode
prep added — to convert the embedded bootconfig file into a flat kernel cmdline
string.

2) Bake the string into the kernel image.
A small assembly stub embeds the rendered file into the kernel's discardable
read-only init data, bracketed by two markers so the runtime can locate it.

3) Add a runtime helper to consume it.
A new helper in the shared bootconfig source — sitting next to the renderer
prep moved there — prepends the embedded blob to a cmdline buffer, panicking
rather than truncating if it overflows. The public header declares it with a
no-op stub when the feature is off.

4) Plumb it at architecture early setup.
The arch's early setup calls the helper after the existing builtin-cmdline
merge but before early-param parsing, so values from the embedded bootconfig
influence early-param handlers (console, log level, memory overrides) right
when architecture setup runs — not later in

Background: the v1 attempt at this feature moved bootconfig parsing
before setup_arch() with ~96KB of static __initdata buffers [1].
Masami suggested doing the conversion at build time instead [2], which
avoids the early-boot allocator dance and the start_kernel() reordering.

This series, plus the follow-up, aims to implement that approach.

[1] https://lore.kernel.org/all/20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org/
[2] https://lore.kernel.org/all/20260417104436.ece29fd5e2cb7a59c8cf8ac1@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c
      tools/bootconfig: render kernel.* subtree as cmdline string with -C

 include/linux/bootconfig.h |  3 +++
 init/main.c                | 45 ----------------------------------
 lib/bootconfig.c           | 56 +++++++++++++++++++++++++++++++++++++++++++
 tools/bootconfig/main.c    | 60 +++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 111 insertions(+), 53 deletions(-)
---
base-commit: 17c7841d09ee7d33557fd075562d9289b6018c90
change-id: 20260508-bootconfig_using_tools-cfa7aa9d6a5a

Best regards,
--  
Breno Leitao <leitao@debian.org>

