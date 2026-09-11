Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB858124E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156579; cv=none; b=CEARzOUp6+K8uhU48ay03KCQeEczPpbC+HBwgSc2+mefFYBdDICFL4pL5VdYUoUXtlLLWpjMHARq3GC9bo/3YhRKD0KECF69UQMY2gF0pOj3ZV0i6MV+GMr3HWtRFeoDKWJs0zpCE9fqgmdu3/JuE1wocsj9j8N8Rd0oAzFxyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156579; c=relaxed/simple;
	bh=MuXg6y241kQAFFXgtK2Q3UkQFZr1v0D+y3gdcjdSvI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oiYWlhQIxJyj7amfuDTe9xxVEILjRKuODmMMdbDIxde3n8iQa+ObESu9cv4e3B2QlPC+YK5TP3X8e0Gy+8MLLlXzICL6fsP8I3yheMuAFrQhOE/T6bgT9Sj7hfX5CJvPOLmWKPKHcxAJjJ1fXz3zApxMXx6fMaM9hFBb4DSVHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNN24k9M; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNN24k9M"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2055573c8cso204932066b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789156563; x=1789761363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VbxJsFTbQ+RydGePFrpF5dFVh+W/MFXSp8uy2MJMaaU=;
        b=PNN24k9M8dVAGL8x7ciTQZ44C20MJ8Kj2jfC8cWHrn60dNP5vW6DzIwEI95FGciRUr
         zVDqyAkqgwGWNqsAAeJEXUkoNllXuMG0h4OKmnxE6ee1Vm+HrAZ1Wm/trBrOrzfYm9fo
         QrtLKwA9yrsg1t5oD2NFqn936poJJgcZidGWT+LRjFrLm87ikyxRVIDOnXwsjQQgC6Z4
         4M8PYa++upd5egNnZ6qJ7wTMLxTnj4g/btxW2u0438RDq6EsIf/yMWgmzmUdIn/8cs5l
         AvswYJrh8qSRdRNnbZglzvycyT8qOhYRAFzJ7B4BGePPICvaIu+533364JEOc96YGFig
         dPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789156563; x=1789761363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbxJsFTbQ+RydGePFrpF5dFVh+W/MFXSp8uy2MJMaaU=;
        b=B5VDG1OWbBZuxkNRtPe1r76jZkuAJMRdlfxW3RUV1PX+vyiBUyEt7t6HM7XU43+74q
         6+P44K1OFC+6Z60JvQB3OQp8MAPRO9ePj5RBrOPcsQL+GIuVbX9DKSW2n3Mko1Dyefx8
         F2R4hKpvBk2thq8lq11n915N9IUsLcryNbxJjq9mNQoDRP2R8lI/Tsw/cvR0cKCYHD0W
         0KFvaHMyPx/CmH/nxDKf6XWioz1YfPy7c2sz6nF3fjnU9t+ydERVg5CurxR4/61rjhJi
         B7va926W0mzqTDlTMqmx6350OKqmWia7cJ18TvQzSAtGzQW0bBTfcOmLxRtGz5lG9B6G
         Pk8w==
X-Forwarded-Encrypted: i=1; AKwUvBysg4klKNpL0HeGQipKwHE7UtqcBkSeKKuJdpV5BvYN2tlgbwbbdYLGQD0LhHN3d0Sbbad59BbRjvmJmRRaIGAeusc=@vger.kernel.org
X-Gm-Message-State: AFuF++l5Wj7wqwYOIwSmI5DN0OCmu6v/PXweW6GK2Gcv7FhkqUJCjb/0
	r67sOg91XGQAPs9QrC8B4C15J9j2cslQkA/7TFwtwnW7bvYPUmP0IdgE
X-Gm-Gg: AYBFou3WoYeS7KLJ/uhOZhtM5GP2wTubUS/v1E4fncKKwpT0WrqV9i95sv12vJNjela
	Ss6cn5SIh3ys1cIRm9luGNIZqnWaPsfvlOjEW2vUhdseqWakJjd8cPu3VTMq8G9KxZDP3FVpRa+
	D7eCVnIs1ugJg3V9yMu7tKQd+Af2pGixPPDvxFJHY/C92Q7nXShrp9WsEokGiTt3aufPwIQzNRO
	PWUZfHQONk78tO1a/8uIG/4AvlAhHNW70agNC6F+S+nR78HGspq3R40xPC9Vwcy13KjfKjj1QPc
	PL2ZB7zaQbctR/UhEInxDDFWmxSgdtsk59jNX4XwbNU0pepjZeYWZQTVoUBKtTRGxE9VL1RpMsJ
	b6RpA7c1trlDjokBRbXwwD1Ny0DkBzCk2IPDQvFIqDPpUHuw9N7kt4cCaXtJZVJbT8JGsmIikiB
	F5Vp1J+q+91S1zW8xfD23Gmdhdk74pQNT9V/I6upCakt0llGMkdmSql4xTvsjHymfe6PuVBkPaO
	ARFs/38XDsnMw8UBRXiwY9ypnpfSs5PVQyFeMPPer1oy6X9JnWZJqVY2rY=
X-Received: by 2002:a17:907:c28:b0:c25:34c7:44d1 with SMTP id a640c23a62f3a-c2966235aabmr287609966b.0.1789156562685;
        Fri, 11 Sep 2026 12:56:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4cf01sm121013966b.1.2026.09.11.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:56:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin Kaiser <martin@kaiser.cx>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fprobe: Clear the unused part of the fgraph_data reservation
Date: Fri, 11 Sep 2026 20:55:59 +0100
Message-ID: <20260911195559.230709-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fprobe_fgraph_entry() reserves shadow stack space for every fprobe with
an exit handler, but only fills it for those whose entry handler returns
0. fprobe_return() walks the whole reservation, so the unused tail is
parsed as stale headers from an earlier call, and an exit handler can
run twice or despite its entry handler asking to skip it.

The original memset cleared only (reserved_words - used) bytes, and
commit e0a384434ae1 ("tracing: fprobe: do not zero out unused
fgraph_data") removed it. Clear the whole tail.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/fprobe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1e9b00997ff2..bd84a982961a 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -635,6 +635,10 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 		}
 	}
 
+	/* Clear unused slots so fprobe_return() does not see stale headers. */
+	if (used < reserved_words)
+		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
+
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-- 
2.55.0

