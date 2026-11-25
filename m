Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632291;
	b=v6sHWXzqnvrsS9HzIRJ56eKg1QFJRIpjuBCcseLvKTBKaRE41Mou+EnKPA9CLrIfxcxp
	 E3pEJhah276OpWrFT2IJ1+4DTRnu7SWhOeVW3Iet/WiFWIQA4FwNzlTiLJQK6oBQYh7Ry
	 OGYt7grpNsDjM909Bfe6X5Guc7DzbZQrZomHLETShgPHjr21cUI/xC3bz5ruHPJGsNym8
	 BL/MkKGnZ7jTiBryqee+uFq/UmX/ZR9/elD5mUgC3JbgdypLhPZLeqCvSqTjK9HTlb7gp
	 cjsrwWgUWIttEAXzUN3S04cQK8+X/stgXVXcyFV3zRalAhW2OXfjfJeqzWdvjvQ4ZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632291;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=6F84u6ZBVj7ALWr80TaqS6VtUD2KAvnZJ83oz57lmZc=;
	b=xqWTlnqKk3Aoh674pWFwExlqX1skXEzMfjBemA7OgpmxQTb0hatHoQgBk9fAunVMKU6G
	 AQROCxPvcJNQJF2+F8czhsb4HZ+w6eOGbmNB7PbM7JScALVOJSzLbRbcZWDBits05sWTH
	 FVPihYaCU5eoN3mjd+zdU5UTtNdNDvYfMPIH9jPJiFbJDX6sPufMkJao2MofNA+GR4/0H
	 TfZuQhRUfySKo84K6KO1nqjpGd3wcDntIY5jZxy5ompqfmvJ6sjTHVTxHrQkyJRrSYY41
	 7CddjAFwGnjQgOeD4RGigwpmJT+XRyj9w9T3Tc5SAzDYm7UI2VA8Cey0h8HvI1ahLEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pOXUaG3v;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46956606A31E;
	Wed, 25 Nov 2026 18:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46956606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pOXUaG3v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795632288;
	bh=yxfmqiNlPULeAg2Eo0frbq3KoaSsflm2PJoZO/n5BNA=;
	h=From:Subject:Date:To:Cc:From;
	b=pOXUaG3v2Oir5YLQg3e8qaSg8cOpi+BVPlyEixuHDKm8Vb4bBZHFhxz6+NcyBpsME
	 kEOZ+8VbX4Shx21q3CEOf4Ez8aOlri87czxNs7uZQr3FxmZwQ+QZayqsfe0+F25yOQ
	 tV8wnYHb1V/c6k+LcFA4J5HYiFem/0Wj1L5Ez4U2kUGrg5CnlVlcVaFwIwBPPfWNM3
	 pKovJSbPyTo1zlp5Gcqzq/CIPzsOZS9Y8wS5zWm/NMIV0GvvUiV07jrVZMZabqVqK8
	 gGi4cEa2LEWewI81tXM0uDQFhasyPLu7ypiWnapyZtv9/43K9Y26MdEUfwkfnSaqoD
	 gmIumRH1lBt2w==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 674EF17E0EBF;
	Wed, 25 Nov 2026 19:44:46 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 0/9] v4l2: Add tracing for stateless codecs
Date: Wed, 25 Nov 2026 13:33:22 -0500
Message-Id: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr2Jm7ZhStagr72FYDNOp1CA1LTYaw
 t0FdOfyJe+/P0CS6CXBaTVAlOyTD90E2/UKuKHuKujtxKCVNsqoA+Zdq5GsRddHYkESNlI6o8g
 wTKtHFOdfS/FSfTk965twP2dmo/GpD/G9XGY9e796of7qWaPCY7k3Yl2piYszh7alOkTacLhDN
 Y7jB48EffjEAAAA
X-Change-ID: 20260608-v4l2-add-ftrace-aec6e7f60a6c
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Detlev Casanova <detlev.casanova@collabora.com>
X-Mailer: b4 0.15.2

Hi !

This patchset aims to improve codec event tracing in v4l2.

The traces added in visl by Daniel Almeida are moved to the global trace
events.
They are adapted to trace each each field separately and not just the
whole struct so that userspace can filter on different fields and
libraries like libtracefs and libtraceevent can be used to list the
fields instead of parsing the trace printk's.

The trace event templates are also reworked to avoid long lines, but
quoted string splits are kept as they don't cut words.

To each trace event are also added a tgid and fd fields, helping
userspace track different decoding sessions (contexts) based on the given
file descriptor used by the given process id.

Also for better tracking, stream on and stream off events are added as
well as HW run and HW done events to track decoder core usage.

The main focus is to be able to generate perfetto traces to show VPU usage,
a perfetto producer using this can be found at [1] (it will be renamed to
match the more generic approach than hantro).
Other controls can be traced later as well, this patch set only focuses on
mem2mem type drivers.

[1]:
https://gitlab.collabora.com/detlev/hantro-perf/-/tree/hantro-improved-info

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
Changes in v3:
- Rebased on master
- Fixed sps_st field size in traces
- Fixed checkpatch issues (except parenthesis alignment in trace headers)
- Link to v2: https://patch.msgid.link/20260610-v4l2-add-ftrace-v2-0-9756edf72ac1@collabora.com

Changes in v2:
- Don't modify the printk format
- Trace all fields of the structs instead of the whole struct as a buffer
- Remove fdinfo patches (they will come in another patch set)
- Fix long lines
- Rename v4l2_requests.h trace header to v4l2_controls.h
- Add basic documentation

To: Daniel Almeida <daniel.almeida@collabora.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org

---
Detlev Casanova (9):
      media: Move visl traces to v4l2-core
      media: Map each struct field to its own trace field
      media: Add tgid and fd fields in v4l2_fh struct
      media: Add tgid and fd to the v4l2-requests trace fields
      media: Add missing types to v4l2_ctrl_ptr
      media: Trace the stateless controls when set in v4l2-ctrls-core.c
      media: Add stream on/off traces and run them in the ioctl
      media: Add HW run/done trace events
      media: hantro: Add v4l2_hw run/done traces

 drivers/media/platform/verisilicon/hantro.h        |    1 +
 drivers/media/platform/verisilicon/hantro_drv.c    |   14 +-
 .../platform/verisilicon/rockchip_vpu981_regs.h    |    1 +
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |    4 +
 drivers/media/test-drivers/visl/Makefile           |    2 +-
 drivers/media/test-drivers/visl/visl-dec.c         |   76 -
 drivers/media/test-drivers/visl/visl-trace-av1.h   |  314 ---
 drivers/media/test-drivers/visl/visl-trace-fwht.h  |   66 -
 drivers/media/test-drivers/visl/visl-trace-h264.h  |  349 ---
 drivers/media/test-drivers/visl/visl-trace-hevc.h  |  464 ----
 drivers/media/test-drivers/visl/visl-trace-mpeg2.h |   99 -
 .../media/test-drivers/visl/visl-trace-points.c    |   11 -
 drivers/media/test-drivers/visl/visl-trace-vp8.h   |  156 --
 drivers/media/test-drivers/visl/visl-trace-vp9.h   |  292 ---
 drivers/media/v4l2-core/v4l2-ctrls-api.c           |   10 +
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  113 +
 drivers/media/v4l2-core/v4l2-fh.c                  |    1 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |   37 +-
 drivers/media/v4l2-core/v4l2-trace.c               |   48 +
 include/media/v4l2-ctrls.h                         |   19 +
 include/media/v4l2-fh.h                            |    4 +
 include/trace/events/v4l2.h                        |   71 +
 include/trace/events/v4l2_controls.h               | 2705 ++++++++++++++++++++
 23 files changed, 3026 insertions(+), 1831 deletions(-)
---
base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
change-id: 20260608-v4l2-add-ftrace-aec6e7f60a6c

Best regards,
--  
Detlev Casanova <detlev.casanova@collabora.com>

