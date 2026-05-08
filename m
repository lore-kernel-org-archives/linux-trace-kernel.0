Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03316375F67
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270275; cv=none; b=NMIccXSyhf00hW9Yu+IRkeoEXkiBRtT6Hel8YayAu/GAag4YML3RsHlWPNhyGn08rwOY8wCnk46qQ4PaS/ftmz0r0U0dyZZDJo8enkyyNsyeFoUWJemMwegBlwRzeKrlya+oZXA8BWqevAZgb0eweXyEQZTZTU8f8wk5o4iYMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270275; c=relaxed/simple;
	bh=2nm/wSPiHuTesoEk8DBheXd60NMSy7T/jUsqj5QURIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvum8NO6ZApf+jMBWRKxTUxTT0D6Zj8sCb0g0UZQSmF+5fjqre8eaZmUlqbJB+mOcOOfHIEyqqJUGp+47Zv2ivQQdeSJztkVcGxVRn8dE6LGiPTPhpOSNg1ktQrxTCtqbl0WpflJavRs/+FJxcqUdWcN+NcTlOm8aP3u2m/bzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgeySGPB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgeySGPB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so14263215e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778270271; x=1778875071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwk6cdJ5Vm9d5Zq49Xzi7ep6F8qp1POnwWpCsgCY/WY=;
        b=GgeySGPBr6HbgDXCADzAeiOjnRD/05huhXCGtOz8KlA+tBYZ5zoaGsI54F2q/L+ha0
         WKIU81d3v8UjBK0lYoCic/qD35DP5hawISr4082h6VSe2qQCP1pMfbTw3ux1a16sP1hc
         3QG6tfZraF9T/QbCwtOk0ISOAbOh4UUSn3Bm2pcJ0yUaHU5OYzzdkn81neuRUtoVi/z6
         mkpJk49nFJ3jU8VSKGPXPAsYtJWmh4Ik9jnwSyvmj6oGBAmOaFCsFIaBoIMmjoFASZGs
         rK4ShkdMKmNePcL2JeEQ43Gg3llvcGI2FYaacal2o2mdSezllRhWKglpJ1sRpPOpHYyg
         9m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778270271; x=1778875071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwk6cdJ5Vm9d5Zq49Xzi7ep6F8qp1POnwWpCsgCY/WY=;
        b=LdbfCqofdoG6vxoqtqJPFPy65SC6Tt4Ekrtm3krrODdHanpcBt0XPb8ooro9FBnqex
         joWRebIWI2SEB4TqnR2h40pVLWXk3G82bEeCj0Kvs55+OqjomdZGTI3RWa9JvJ4ZASWQ
         Bo8n88FSfFnaR5Hdzdbu5QtL2oPMJ34YyrAsnLGbdcmfC7oUA8mpH1nXfvrTYysYdH0Y
         OZY35+eCW8FKYbnBkujC1aC5G2cybXcoi+ipeRIrUkliUO3SIdxlk6ns5umY4LxYzZ8M
         FuhEtuuP4zplpueg9X+XT3EENNM11dYeVyBiDTCG8drKc7eA8ps0ANGOOLJHih2YU0Ts
         pmYw==
X-Gm-Message-State: AOJu0Yzr4/FEJwlIb0RiNfJreCylneJfQ/PVXEOW5hlPpUuitlNhQ4FC
	Mm3vVzYmVSNAeKZ7sqcB+SYVasavXjpdB7ogai9WD+XyomW5p0MWxKnoEiVs/r5m
X-Gm-Gg: AeBDieuTgL1oFNbDP3S61XjaU5fjOyGkqL1VKp45he9pA9eoXU4PYFqQC4KQDS4vkzv
	KdMjbSedoXKwmjNhK+Xhgs8pqdVmX4Ukf7rOpvLdXXWUxiWfQYuiuzElDK0JwNgDS8aiUoOWgv5
	JsV9Cp16QHJPAaoYdK8JhX+nouZFr/g5rXQ/LY+Jap/lFcpuBcfMXUqavHFpz+ufjTX1XU+I5EV
	y5DtEEJ8/21qlCyiibBt8c4p+YxE6n9FhRUS+H5A4Y8HjBJ2fCokVTNlhicRO4CRDD7l7pnYUQ6
	LeRqGSHEcNab/UdY/12ZHHBhh6eYduoOZHkIW5SO04Dqu5CtRInITHYw9/qJ7KOiq3Acm2tguSe
	zI25F3V1Rc5JvRcEBOd+cGnpmFtGbxoSnDLAiUmm36+Xmggvhj08smQLaArLIz6i3qNlm+g+w81
	+Ey9vRQT0I7c+t029845FsjrGIxR9zr24MCTnnFXzQUXDRbZS6GBekw2CDjVg4EQ2Lgz8Tq5/LF
	sBkxBQ2sQ4=
X-Received: by 2002:a05:600c:4e0c:b0:48a:55d8:7882 with SMTP id 5b1f17b1804b1-48e51e16e58mr235991945e9.9.1778270270997;
        Fri, 08 May 2026 12:57:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db171c9sm6526355e9.30.2026.05.08.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:57:50 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	zanussi@kernel.org,
	pengpeng@iscas.ac.cn,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracing: Avoid NULL return from hist_field_name() on truncation
Date: Fri,  8 May 2026 20:57:47 +0100
Message-ID: <20260508195747.25492-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hist_field_name() returns "" everywhere except the fully-qualified
VAR_REF/EXPR case, where snprintf() truncation returns NULL early
and bypasses the bottom NULL->"" guard. Callers don't expect NULL:
strcat(expr, hist_field_name(field, 0)) at trace_events_hist.c:1758
and the strcmp() in the sort-key match loop at :4804 both deref it.

system and event_name are bounded by MAX_EVENT_NAME_LEN, but the
field name on a VAR_REF is kstrdup'd from a histogram variable
name parsed out of the trigger string and has no length cap, so
a long enough var name in a fully qualified reference can reach
the truncation path.

Keep the length check but leave field_name as "" on overflow.

Fixes: 5ec1d1e97de1 ("tracing: Rebuild full_name on each hist_field_name() call")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events_hist.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0dbbf6cca9bc..eb2c2bc8bc3d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1369,10 +1369,8 @@ static const char *hist_field_name(struct hist_field *field,
 			len = snprintf(full_name, sizeof(full_name), fmt,
 				       field->system, field->event_name,
 				       field->name);
-			if (len >= sizeof(full_name))
-				return NULL;
-
-			field_name = full_name;
+			if (len < sizeof(full_name))
+				field_name = full_name;
 		} else
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
-- 
2.53.0

