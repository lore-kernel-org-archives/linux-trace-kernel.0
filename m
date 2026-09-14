Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B637C90F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364102; cv=none; b=fX3f+LfEzjDnmcBDmDGQ+koj9+c34wkFHOVOlDoHOvYNGgEQwwH5wneBx6PdxaeuHYqJVz3Ymp+MUk3O9Aa8Iaj2s3wrI8d42VomFl+2BmAHeIBwHNqGdHliSY6l5EgrDy5icV+TM6jq2N013weE0H+8UQjpoDl5mznSc5ELOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364102; c=relaxed/simple;
	bh=fs+etxGPNJdOV8jLbNvbk7g0T1Q8B3rjAqWSv5XnrxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+Zve+XW2+LyYvonxkeMI4YhMHVmmgoRFb3uuWOznbB9B+rIcMQqpeDdODum7Z713JyHAlM+xMjOJNOUtpCpCZG9GPz5jb0lKStIZBaTZBmmXHYdKMOKPq1EAcF92QTaojyN6w0GkZOfvioudv/f0jBjC/PGIJdyG4aWLpiUlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm/abdGB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm/abdGB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so1151838a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 22:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364101; x=1789968901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MjygDWKH6F7NI1Gpi2HW71UEUzq+rkDAiIqSWm+VeuE=;
        b=Pm/abdGBGVmmCR4O4XNowaHqS9EGK2lzvwnTXrpGZP7MWQDRZm75fhxGGV9zoEqsqE
         /jsFo05oB1BoIRv7llXWmLWNbhpEQMwdS30ROC/nlV78kA6iZ9V8OD5d0gH5w/EEjOwy
         7LJi0ijKZcCIQCccAMD8lpOW/PRVGzJX1ABjU1dFsYWKd0JEucWszShvw/sceg3ot1fe
         WJ3XuVjokxX21DuzVA41TAyqtunhqqOI2lJ/S8JVmUmPWuBbuXm1y6RYkMVswkzR3L7m
         6SnaZr4I2xpzW7lTv5kcpE0nKlH5M0hyE0hzBhYLqU2g1eLLZRMIP8+TqLtMdw08tuO2
         Ueug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364101; x=1789968901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MjygDWKH6F7NI1Gpi2HW71UEUzq+rkDAiIqSWm+VeuE=;
        b=N/Tq86yzIyvs3iBpoZm/jDIgzwBo3REZENd7MMFGPsPbtvu3JrLO601ZXWi8CxPWbb
         RpEg91hp/cIQcbBZSx42SrAHTg8ClkUVbEDofqCAPEslNVwK+qBOGVF4Ut5Ifu7t34+M
         YHq+T1Mp1+MsfhPDj3emQemLQjZmCEroy9X+v6Kz3p6WtbhFUDPJEkoy16gLIklzjYNW
         JSaTBg7Xt7XnBPGMmGPzjb42Bh7iZh68ICnfz6se7wGmalAHtwe11m73WHqo8qtNh/cV
         rE5EM20pAmlgyS9lhPXW1xZsYgyownqie6XkEzm6gz07R6HfhD3DFWqVDyYuhvcXcLtu
         wxdw==
X-Forwarded-Encrypted: i=1; AKwUvBxcfQQiyUUjZIUCsffCDsFah2qEQU+iWY3GaDTWbtNPEkLf2iax2BQPqa+DwW0aJqx4vvCCv7tcMSgGeKHkQWsj75k=@vger.kernel.org
X-Gm-Message-State: AFuF++k4flR/k9G8wj3vuAEeJXs71vAuaE/yRxlMSmgSqzovgynktNnG
	sTQmGdz1XxN9oZEvlN5KKZUYBt/eCpxAFPgDAk0W3AY/XgzVKHRKb9Q=
X-Gm-Gg: AYBFou13bZ4nenJeDs8KRBiogygmrtOS9PPO4XT6QCI1EItwQNE8wPl22M1ammJdlmb
	wAqEH49/qjhX9juA5Z3ZFOTHr41FmhONDmS45Q9qctbPeWln3gktOg90A1kv5Bl0qCWZDtt/qV/
	ycFwVje2F6+1yXo1aA7zpASevLwQfM5/Zjvm2vwSTBEML3dAeYxLIcSZLmS/0foi6dbiKwP4FQr
	lYyoxK0zPHDC2Ak79XJjrg8UylkoXX64shg40r3pb4YoHBALnatZ/OXOECHyHrbVjOPZfyuiRB1
	vSufW2NfGVmTWv5tndBSwUONlGtUv7GrefDFJmLtwbe3z+2XiyBM9sa0cFVD/Weol1+As6zahG4
	eOOvVHx2BQLkIVP6pBY62VJGb44lUPfPnwaSqNLW48F2eypnsBZMw5q/b1Rh1px1stVCZCx+ZYq
	zZc882fWa6jlzyRX0GkrsmBzyra1KKkWUUcXj/kEgYIeBbrOUwcWrrN3l0rH6IbR/SIcc/H9HPW
	lkDhXkupqD1UGd1okS4nLlZcsCT7XvHBozB0w==
X-Received: by 2002:a17:90b:3e4f:b0:398:9be6:f997 with SMTP id 98e67ed59e1d1-39dec0f7abamr2852464a91.22.1789364100475;
        Sun, 13 Sep 2026 22:35:00 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm19009261a91.8.2026.09.13.22.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:35:00 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH v3 3/4] tracing: Only report the stacktrace modifier on a real field
Date: Mon, 14 Sep 2026 14:34:42 +0900
Message-ID: <20260914053443.981201-4-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
References: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_hist_field_flags() returns "stacktrace" for any field carrying
HIST_FIELD_FL_STACKTRACE, including the common_stacktrace pseudo-field,
which has no ftrace_event_field behind it. parse_field() no longer takes
the modifier there:

	if (stack_modifier &&
	    (!field || field->filter_type != FILTER_STACKTRACE)) {
		hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));

so expr_field_str() renders "common_stacktrace.stacktrace", a spelling
that cannot be parsed back.

Report the modifier only when there is a field to report it for.

hist_field_print(), the other caller of get_hist_field_flags(), excludes
HIST_FIELD_FL_STACKTRACE before it calls, so this is confined to
expr_field_str(), whose only key renderer arrives in the next patch.

Fixes: a5e70ba87ca8 ("tracing: Fix memory corruption from the histogram stacktrace modifier")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 91a550411e8a..fdd097abb0d6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1725,7 +1725,7 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "percent";
 	else if (hist_field->flags & HIST_FIELD_FL_GRAPH)
 		flags_str = "graph";
-	else if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
+	else if (hist_field->flags & HIST_FIELD_FL_STACKTRACE && hist_field->field)
 		flags_str = "stacktrace";
 
 	return flags_str;
-- 
2.53.0

