Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9B1FF059;
	Thu,  7 Nov 2024 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981135; cv=none; b=nyBJO3fkGqQf3pRYw0qKt2KSSzDSLpI9KkLXPQ9vEanYD1d4uNM0fXdBLzR16w4DmgpC6F+JdGChXXI5NMD6SOnnah/RRnek2Ny/XFPiXzEusuKKN0ZixrBO+EBwAtsKIogDQegQ/mTaX/PNH72UaDbfF9XuaqPHe+sP8eRcycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981135; c=relaxed/simple;
	bh=sjinbzYvoaBHlsCw2xi4xaShAx2giRtnnvGZ1ISq1Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YJaWrNzz032eYifrfJtkrzY69USlZZfXdTUt1FhMlD7Kr3Q4humosyOlk3MqVPJK+sY27dHSW6kH2qpvUWDFmJUb2S1baLeboR9FB+LuM+6lpr9JEsfy8S14Y3wWMACWUDFpO0BZ/tVbe2J0Q74X9O8Sgj3hMx5gbeqJoZNFjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUEDVvFU; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUEDVvFU"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53c73f01284so870996e87.0;
        Thu, 07 Nov 2024 04:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730981132; x=1731585932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ed5v9Iqhp+uxCA7p1WfrmQ+aSwipNtXMP5g/GOOgn4=;
        b=QUEDVvFULePeu/vv0uT34ppdHg96LrQOpoSts/9zH6Fl6scUBpkdPdlcKOc/80vgpz
         PGcsG+/NiY6x1BvCBAAiiv4PrK2YzJ85v3rYoaECIgFlsIu4rHZYIQ/Lg7pw1zrKQGjO
         DFpQisqlVIVQyLE4Ui8urg28KgE/GofDtJ1EDdz/l/T0r6Qr9V/VK990htzkyW44cx7h
         6ZNO/HXUWMcbhNQik0B3QL0uABzuKv3SZ5Qv+6VirfZ4yocOPpmWp/ELoUyxI4xbcnCf
         njilwu9khGy/kZjuUkjVfgb7ro7GgPX/g7pDfjiEQG2xvOd/Twz/qvcUcvuMiRkFCpaL
         HSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981132; x=1731585932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ed5v9Iqhp+uxCA7p1WfrmQ+aSwipNtXMP5g/GOOgn4=;
        b=GQLJeGVM3Gvm7WUT90MqHDdmEI7G/8yAsQkShAczmHM6rl0eacphr7K/ZRxMhE233N
         AWuHAdRX78yqHF/fYlwyhQzFwjdvDXBjvYBnragADiMaYqtjZTXLrPDmJOKU7RqZfcL8
         3TWXxMwSprvOu2gt0VAa0hwE4QGyIVO71X7Yyz8G2VPowkxRKRS1ZX51ByKwp0xM1bur
         yifybhNBfbxsXzMgvtXHrZw2qJ8Eu3CrlyS+rtmDNwN5YTmpQuJJoa6bSBDi2Z+m9dMX
         RiyujxqW3JixuWzG9F+7mAMvyWzmfUUbiMdjs+kSjYwmSWk1cFhymEMLmIsgyuKbOnCs
         rttA==
X-Forwarded-Encrypted: i=1; AJvYcCU/psbzbhb6po2+BvOdqAInKdbMenDXt+eJQndk9+iuUyU+1p1q5jWL2tLA05iORMvcM5W7t8rwDNrlYIg=@vger.kernel.org, AJvYcCUAhu9Y5C4l536MSYVgR/Kc+OFm41v9OIjHIbA525GaIW03fwL2O2AI4nFHUEpOVXshk4A1CNn0+V2e/wKZAT2mSGPu@vger.kernel.org
X-Gm-Message-State: AOJu0YyfyhJkDVAg2pAqEDdYe+0BwpfD68ZVG3yI42ou+SuWOG5DHORn
	pC5Ilc99AKx7kEZR+jyAQV9WH3R2zpy2MSqPwfV9zn1G63vJ8omCsKe0wpR/oqM=
X-Google-Smtp-Source: AGHT+IFBMqP8BuoxW80jh8oGTcfnxuEajy+uEQ9HQNmmnAcT3s+CKhOIneIsziFsdm5kGluOLRIrsg==
X-Received: by 2002:a05:6512:2248:b0:53a:aea:a9e1 with SMTP id 2adb3069b0e04-53d840a6931mr448906e87.54.1730981131591;
        Thu, 07 Nov 2024 04:05:31 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5b96sm22195695e9.41.2024.11.07.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:05:31 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH][next] tracing histograms: remove redundant check on field->field
Date: Thu,  7 Nov 2024 12:05:30 +0000
Message-Id: <20241107120530.18728-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check on field->field being true is handled as the first check
on the cascaded if statement, so the later checks on field->field
are redundant because this clause has already been handled. Since
this later check is redundant, just remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/trace_events_hist.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c288b92fc4df..9c058aa8baf3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1332,54 +1332,51 @@ static const char *hist_field_name(struct hist_field *field,
 
 	if (field->field)
 		field_name = field->field->name;
 	else if (field->flags & HIST_FIELD_FL_LOG2 ||
 		 field->flags & HIST_FIELD_FL_ALIAS ||
 		 field->flags & HIST_FIELD_FL_BUCKET)
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_CPU)
 		field_name = "common_cpu";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
 			static char full_name[MAX_FILTER_STR_VAL];
 
 			strcat(full_name, field->system);
 			strcat(full_name, ".");
 			strcat(full_name, field->event_name);
 			strcat(full_name, ".");
 			strcat(full_name, field->name);
 			field_name = full_name;
 		} else
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "common_timestamp";
 	else if (field->flags & HIST_FIELD_FL_STACKTRACE) {
-		if (field->field)
-			field_name = field->field->name;
-		else
-			field_name = "common_stacktrace";
+		field_name = "common_stacktrace";
 	} else if (field->flags & HIST_FIELD_FL_HITCOUNT)
 		field_name = "hitcount";
 
 	if (field_name == NULL)
 		field_name = "";
 
 	return field_name;
 }
 
 static enum hist_field_fn select_value_fn(int field_size, int field_is_signed)
 {
 	switch (field_size) {
 	case 8:
 		if (field_is_signed)
 			return HIST_FIELD_FN_S64;
 		else
 			return HIST_FIELD_FN_U64;
 	case 4:
 		if (field_is_signed)
 			return HIST_FIELD_FN_S32;
 		else
 			return HIST_FIELD_FN_U32;
 	case 2:
 		if (field_is_signed)
 			return HIST_FIELD_FN_S16;
-- 
2.39.5

