Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92D15B541
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263721; cv=none; b=OwqZAm2MkyO8WrzWL54+r/KNEcUiI4mQ9n/XPCVe044WzgaSDSVuK/kvs3bZlJB4qVc7U5unZCD/qFUiMk4grJjdl0oWOfBx996JupAgdmNXZGGBxmq23Vo4IYS0oRncVzjQphTsRT2Rr1420/iB67/zpLfWGCdHFuLGnWW/icI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263721; c=relaxed/simple;
	bh=suh8lj5U75UfHLAikpWSAju24qSZjPOfB+HigRwu20c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dnf/a4Rgacb13+wnVLJj+6q7iwCZMvGzZbeUc7mfcPLAR2bzay5U+gGqgXXTseEfPiIT+cRBEDsSi8fWZTrXPGWB7VaZpz8HpKyUJteCLQdhejCS+laVYlUH2mDKc8UeXzMyysE0asmPNF/0/wgnN7F4lKCm768WCv4Z9yaKipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q9mNZuGb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q9mNZuGb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso1637073f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722263718; x=1722868518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wvUKWDbbhCXQe3vpeoWnQvXqGR+nLQUfmDvJ2uq4cw=;
        b=Q9mNZuGbzJeEUICCYpHFKp3DFYoPBXLfz/vQCUnACG5Ucv2DYENh9e4atVGHvW9iA9
         UXXkW6xXr1/DbJztT5VQ7NOvywj31V0fY+oPfDuzWGySh2ZvBWEOI+XKpSg7OcVT1XKN
         r21dA0HFTGl1bLZpXMPWrwN7iI1TyYW0/iLSV5QOcZ4sNlg4TGmLnHktBDVjsEvQK0c5
         BIFMhDoV9ArhesIjf83AgbYTOn8Vv0xNQftH8s4+kdhtxroBZXD9ZmraK3r2uC8d7yJL
         kwpp+VnhRWcna+ghBZdsnVAox/yOmbnK0YTljOPmBfR0VjiyRpMIJkZYcNgwLWPB3QCj
         HoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263718; x=1722868518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wvUKWDbbhCXQe3vpeoWnQvXqGR+nLQUfmDvJ2uq4cw=;
        b=HEONF1lnn0AhtC0UqSAXX5f5x9VLIreV+IKQ7PWwVi2pivOBPgZV+8kRtOyNyQxdNv
         Wrcw/vbizl2GpXK7XrcjxvviW/uwqmHFn7qGq3+dtN7Dt6c6DjXNwRCXKlkvXk840I+y
         MUmLjzhff2SJY2R2SupAHYKV5vd5Jwi2f4iYnptnaw3OWiUveEw1Ugq4OH2Zsn8y4Vd0
         ro4rAwyEetWU/3JKrsKr5RAi8/v1OdIEmOflgAcBudHg63PhZiCVFqO9C93U0tsa2Mso
         oDGjApwavknfZCV3oTCON6bxorYID7IkXNmJIXiBnMvkDd/gczaPAumOUBJVNYGBl3va
         Z+2w==
X-Forwarded-Encrypted: i=1; AJvYcCVgcfh/9K276qkCVhgkeDUfhQ/kaek//5Up7W9aPROyvWKRsveKxISObAh7Eaw1lzX5Kc+yrOCi5MUyTpxE+88Y5yqjPeaOrYMa7DqbvEn6RJyy
X-Gm-Message-State: AOJu0YzhGYWlrK7he3tHJOhqcyNxR3fk033UTRd8d83XSWvo46Oh1I86
	sFpkn5hE4huONqZuJQ4Tg24ut351AVLZtWTOgkU/eCmtyyxsfpWKd3Aw7YjGEG0=
X-Google-Smtp-Source: AGHT+IEkgWMlUsc544E5LVvkbpdFtBtCkGuAxc3whEOFDWg38/1P2KS0HyrYffvmWz30E0pcqetJ4w==
X-Received: by 2002:adf:cd0e:0:b0:367:8875:dd4c with SMTP id ffacd0b85a97d-36b5d0c447fmr5179528f8f.23.1722263717674;
        Mon, 29 Jul 2024 07:35:17 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:59dd:510e:47d0:643f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0829sm12380354f8f.17.2024.07.29.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 6/8] pwm: Add tracing for waveform callbacks
Date: Mon, 29 Jul 2024 16:34:22 +0200
Message-ID:  <7b9c9ee490df1df1de3bbfafd501f45c6cb2ec4c.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6305; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=suh8lj5U75UfHLAikpWSAju24qSZjPOfB+HigRwu20c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmp6h8+2aKe76vTcEkVhxflMS6tCD98MRU23Ao+ 8oDdHvgR6yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqeofAAKCRCPgPtYfRL+ TsWtCACKvnjYofCuiycqmy9MFrD8NFZ6FwGaNaLQwc0rKaf/+ivXoME+L3JwVoNAjLagosyu3+P 87U5esZJdBxp5bx4VkixuySJ4U8Fg1JYtVAuU/Cei/l7KZzXp2BkhBCBeIG1cHAD03FxHQI9u0v 4A0yAyB+1qfQdCn2aH0iHli4deXMzkMcIMB6t8SFwaOIB1I+qN5xEhLWU/HDdF20WG7mcX113Tj IISZ224m7dZaZ/6zZSJA6tqnATtyzLu/I7O5hKYp1v7V+z5PZ+dbfolqX4eCDMlfqWfAqCquCxC tg5vUYJ7TT/xjmcZsI7P1WMpB3JwmS0H2zrB2ejCBXrzPFYQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This adds trace events for the recently introduced waveform callbacks.
With the introduction of some helper macros consistency among the
different events is ensured.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c         |  24 +++++--
 include/trace/events/pwm.h | 134 ++++++++++++++++++++++++++++++++++---
 2 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 888cd4f51c6e..bad0c8e65f56 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -166,30 +166,46 @@ static int __pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *p
 				     const struct pwm_waveform *wf, void *wfhw)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->round_waveform_tohw(chip, pwm, wf, wfhw);
+	ret = ops->round_waveform_tohw(chip, pwm, wf, wfhw);
+	trace_pwm_round_waveform_tohw(pwm, wf, wfhw, ret);
+
+	return ret;
 }
 
 static int __pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
 				       const void *wfhw, struct pwm_waveform *wf)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
+	ret = ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
+	trace_pwm_round_waveform_fromhw(pwm, wfhw, wf, ret);
+
+	return ret;
 }
 
 static int __pwm_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm, void *wfhw)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->read_waveform(chip, pwm, wfhw);
+	ret = ops->read_waveform(chip, pwm, wfhw);
+	trace_pwm_read_waveform(pwm, wfhw, ret);
+
+	return ret;
 }
 
 static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, const void *wfhw)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->write_waveform(chip, pwm, wfhw);
+	ret = ops->write_waveform(chip, pwm, wfhw);
+	trace_pwm_write_waveform(pwm, wfhw, ret);
+
+	return ret;
 }
 
 #define WFHWSIZE 20
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index 8022701c446d..8ba898fd335c 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -8,15 +8,135 @@
 #include <linux/pwm.h>
 #include <linux/tracepoint.h>
 
+#define TP_PROTO_pwm(args...)							\
+	TP_PROTO(struct pwm_device *pwm, args)
+
+#define TP_ARGS_pwm(args...)							\
+	TP_ARGS(pwm, args)
+
+#define TP_STRUCT__entry_pwm(args...)						\
+	TP_STRUCT__entry(							\
+		__field(unsigned int, chipid)					\
+		__field(unsigned int, hwpwm)					\
+		args)
+
+#define TP_fast_assign_pwm(args...)						\
+	TP_fast_assign(								\
+		__entry->chipid = pwm->chip->id;				\
+		__entry->hwpwm = pwm->hwpwm;					\
+		args)
+
+#define TP_printk_pwm(fmt, args...)						\
+	TP_printk("pwmchip%u.%u: " fmt, __entry->chipid, __entry->hwpwm, args)
+
+#define __field_pwmwf(wf)							\
+	__field(u64, wf ## _period_length_ns)					\
+	__field(u64, wf ## _duty_length_ns)					\
+	__field(u64, wf ## _duty_offset_ns)					\
+
+#define fast_assign_pwmwf(wf)							\
+	__entry->wf ## _period_length_ns = wf->period_length_ns;		\
+	__entry->wf ## _duty_length_ns = wf->duty_length_ns;			\
+	__entry->wf ## _duty_offset_ns = wf->duty_offset_ns
+
+#define printk_pwmwf_format(wf)							\
+	"%lld/%lld [+%lld]"
+
+#define printk_pwmwf_formatargs(wf)						\
+	__entry->wf ## _duty_length_ns, __entry->wf ## _period_length_ns, __entry->wf ## _duty_offset_ns
+
+TRACE_EVENT(pwm_round_waveform_tohw,
+
+	TP_PROTO_pwm(const struct pwm_waveform *wf, void *wfhw, int err),
+
+	TP_ARGS_pwm(wf, wfhw, err),
+
+	TP_STRUCT__entry_pwm(
+		__field_pwmwf(wf)
+		__field(void *, wfhw)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		fast_assign_pwmwf(wf);
+		__entry->wfhw = wfhw;
+		__entry->err = err;
+	),
+
+	TP_printk_pwm(printk_pwmwf_format(wf) " > %p err=%d",
+		printk_pwmwf_formatargs(wf), __entry->wfhw, __entry->err)
+);
+
+TRACE_EVENT(pwm_round_waveform_fromhw,
+
+	TP_PROTO_pwm(const void *wfhw, struct pwm_waveform *wf, int err),
+
+	TP_ARGS_pwm(wfhw, wf, err),
+
+	TP_STRUCT__entry_pwm(
+		__field(const void *, wfhw)
+		__field_pwmwf(wf)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		__entry->wfhw = wfhw;
+		fast_assign_pwmwf(wf);
+		__entry->err = err;
+	),
+
+	TP_printk_pwm("%p > " printk_pwmwf_format(wf) " err=%d",
+		__entry->wfhw, printk_pwmwf_formatargs(wf), __entry->err)
+);
+
+TRACE_EVENT(pwm_read_waveform,
+
+	TP_PROTO_pwm(void *wfhw, int err),
+
+	TP_ARGS_pwm(wfhw, err),
+
+	TP_STRUCT__entry_pwm(
+		__field(void *, wfhw)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		__entry->wfhw = wfhw;
+		__entry->err = err;
+	),
+
+	TP_printk_pwm("%p err=%d",
+		__entry->wfhw, __entry->err)
+);
+
+TRACE_EVENT(pwm_write_waveform,
+
+	TP_PROTO_pwm(const void *wfhw, int err),
+
+	TP_ARGS_pwm(wfhw, err),
+
+	TP_STRUCT__entry_pwm(
+		__field(const void *, wfhw)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		__entry->wfhw = wfhw;
+		__entry->err = err;
+	),
+
+	TP_printk_pwm("%p err=%d",
+		__entry->wfhw, __entry->err)
+);
+
+
 DECLARE_EVENT_CLASS(pwm,
 
 	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int err),
 
 	TP_ARGS(pwm, state, err),
 
-	TP_STRUCT__entry(
-		__field(unsigned int, chipid)
-		__field(unsigned int, hwpwm)
+	TP_STRUCT__entry_pwm(
 		__field(u64, period)
 		__field(u64, duty_cycle)
 		__field(enum pwm_polarity, polarity)
@@ -24,9 +144,7 @@ DECLARE_EVENT_CLASS(pwm,
 		__field(int, err)
 	),
 
-	TP_fast_assign(
-		__entry->chipid = pwm->chip->id;
-		__entry->hwpwm = pwm->hwpwm;
+	TP_fast_assign_pwm(
 		__entry->period = state->period;
 		__entry->duty_cycle = state->duty_cycle;
 		__entry->polarity = state->polarity;
@@ -34,8 +152,8 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->err = err;
 	),
 
-	TP_printk("pwmchip%u.%u: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
-		  __entry->chipid, __entry->hwpwm, __entry->period, __entry->duty_cycle,
+	TP_printk_pwm("period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
+		  __entry->period, __entry->duty_cycle,
 		  __entry->polarity, __entry->enabled, __entry->err)
 
 );
-- 
2.43.0

