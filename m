Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797940;
	b=YGLQxQ0jtk3xJPHc0iI7Z36ccGn1SvTvjE9OWPtOu+b2g0N9xmCZFK4Ap2Faey05Qrsh
	 cbizgFsGxp7ZdYuk9mkXYdvvvTpUb6mn61QU32aQJw/tGaKc9Y3wvZ3Wc0imBTPWbrwd/
	 reCYbYd+cz9Pgvyxe1CyLvGpspS+XOuVNb26A1jkTuABQAMzPHIo/KC70ddVmlZpA5BOH
	 nxS8ClyshPmsWqgV69Ph1TAug1oVOSsm7zHz3TYpmC9RWGtxhNXZUmWwwlL7vz/kBKdTx
	 zTnCxMnxXd1HZ/sV2JWVus6SOqlD8vNqjZOiUDyTEN5BT/C0EtaWME2jpOimgCotF/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797940;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=lDfky6SuvAz9YREJEg5XyCekcclpWUJwmfT04L5Ocuo=;
	b=5QArc3P35gYE1N6hVuRde8YkoO0a5R90BQMAJwYFkK0cxISVGvooFh/1SsQXzYhoB2zm
	 uhS9Zplz0t+Bn+ryFOIoKxNo3QYz/JXDN05T5I4eWgqBmKu/F+nZxFrJmPJVYlGQj3ZpK
	 zEPhcffdq7rLxGzTAu4JutlPsA198TrQkOL1rdZnMrFDxi+s41J9QUqjr9vRtcfO4sHHE
	 TtNMIihebpcQO1oMKDiST9JLgJBd+eFDVQFlog5BeoYX/8BZF8a2A9/qxMU1jsVnKKQaV
	 c64sirwdTl1UtpGZUNlGojopkTAhEfRHvlhzrk/L6A4tGVUJ9FQAG7I9bGBxkXCb2fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bMLqzdv0;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543D606A31C;
	Fri, 27 Nov 2026 16:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B543D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bMLqzdv0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797937;
	bh=mxFODSb/WKuiMK1tmmBnOBrFqLuGs+xiiCktJN4Ejsw=;
	h=From:Subject:Date:To:Cc:From;
	b=bMLqzdv05IgdzeOe3SjapBamP6TCtIukuOMbct3PvDXhaDkczBi7VzbasX6Tqn5TJ
	 D9cw5r5s/oZw+zdNvkEK2MdIa33Be0PFfPW6yUn2X8bGkfpDuhgS/MzjQDMfxRL1fg
	 EKhUcPQnASmcoT/keO9HriS0wSIl/ushunzN9ZJk5X0yOYEUImLLwiI0iXmm5rL9Lg
	 qluhU1SShJUiIyN9V2NjusmRTR/ljqWFerCjCIq2os3f95uHbgbC6YYMicR79EWzOV
	 rAyao3sVrGeh8hGxrgoSeFNKzwpi8OdvYZj/I4ZnqNZq3BF1i4b06o25k8p3/SQLM+
	 NdHtoYwwM677Q==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED1AF17E010F;
	Fri, 27 Nov 2026 17:45:35 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 0/9] v4l2: Add tracing for stateless codecs
Date: Fri, 27 Nov 2026 11:45:04 -0500
Message-Id: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNQQ7CIBQE0KsY1mKAtrS68h7GxS98LKYWA5Vom
 t5dqMaFXU4y82YiAb3FQA6biXiMNlg3pFBuN0R1MFyQWp0yEUxIJllDY9kLClpTM3pQSAGVxNp
 IBlKRtLp7NPa5iKfzJ4dHe0U1ZiY3OhtG51/LZRS599U5W+lRUEb3dSVRm1qA4kfl+h5a52Gn3
 I3kh1j8DM5FtTaKZHDNdVs2RS1Q/xvzPL8BY14asAgBAAA=
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
a perfetto producer using this can be found at [1].
Other controls can be traced later as well, this patch set only focuses on
mem2mem type drivers.

checkpatch.pl reports alignement issues in the trace headers, they are
voluntary. No other warnings should be reported.

[1]:
https://gitlab.collabora.com/detlev/v4l2-perfetto.git

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
Changes in v4:
- Update visl doc with new trace names
- hantro: Move hw_cycles in vpu to avoid ctx race in irq with watchdog
- hantro: trace run before starting watchdog and done after canceling watchdog
- Trace controls from p_new instead of p_cur
- Trace controls if there was no errors
- Add missing EXT_SPS_LT and EXT_SPS_ST tracing
- Allow fd to be 0
- Also report queue type in run trace
- Move v4l2_ctrl_vp9_frame tracepoint symbol to the VP9 code block
- Use s32 instead of u32 for file descriptors
- Fix a HEVC flag print in trace
- Link to v3: https://patch.msgid.link/20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com

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

 Documentation/admin-guide/media/visl.rst           |   24 +-
 drivers/media/platform/verisilicon/hantro.h        |    3 +
 drivers/media/platform/verisilicon/hantro_drv.c    |    9 +
 .../platform/verisilicon/rockchip_vpu981_regs.h    |    1 +
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |    2 +
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
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  131 +
 drivers/media/v4l2-core/v4l2-fh.c                  |    2 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |   39 +-
 drivers/media/v4l2-core/v4l2-trace.c               |   50 +
 include/media/v4l2-ctrls.h                         |   19 +
 include/media/v4l2-fh.h                            |    4 +
 include/trace/events/v4l2.h                        |   89 +
 include/trace/events/v4l2_controls.h               | 2704 ++++++++++++++++++++
 24 files changed, 3076 insertions(+), 1840 deletions(-)
---
base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
change-id: 20260608-v4l2-add-ftrace-aec6e7f60a6c

Best regards,
--  
Detlev Casanova <detlev.casanova@collabora.com>

