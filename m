Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CA28C01D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 May 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926348; cv=none; b=XFc00xxU6w57vaHBhVoFab0ui8Ol08tnKymZqhBqfYrAG7gQVtYbsSN3wRn5GBNF7rzwBAudFPnQUIkYcMPBD/0cgXZx+qJ30KUkflqsAmzvX9Sxm9Ia8Od6BJWGa+HDVmG44Nz/HzWqvuMWSKepc07UfqMmRUPFEltL8XX4hxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926348; c=relaxed/simple;
	bh=7H2/E89fciRxCRq+D4loQo9VPhae2DqqRu/RRY5fbaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRbQ3NQpfImQdkh4XHcQ3y1+fck6/xp11beRx5KSdu8p3dgB7A8y/rqrHgA8lWU4M2AL4mGOYruXzG50hZQl3ttAHe4H2F6P01vwjRGjc84Nb04OHgcnWvdUhOQkO9clQzF/YWt52lDTAQrvWJVf0BG8oweQRDvom0pxBIuNGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UZjVpM9c; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UZjVpM9c"
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-6026be5e965so544218eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 May 2025 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747926345; x=1748531145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfVvvdWGG0adnBwzws5Hqth/btOaihCNY1aQF7gASIY=;
        b=UZjVpM9cu7Ti7Q8ewkdTEhmJqXeQw69vvPJIGnzX5h7ZrezZAZ5Ibj4oIYXZPR9sWy
         ujHyfYif5Y6xt7mAmrmy3qY1ywPit2EJQX0y0FFWSVgRBdIcMNV3cpYNrgOGguJ3yqls
         ybXYWcyKZ6RK8mUJ9sOErf/9Lvo4O0wVkoqxn9IgG90EJn/CLqmqLnuLxqovuiau4dIN
         vsB+qbXgJTCCFHlxfcpxiVSeC+DxtDwJ/8FMTzQyAGbNfpTs2qjpSLJ2a9J21LjjAZVs
         Nlc66XqKAiF2ii9xSi+jFbtURt32bcM30J22W4K9EuVUnuxUBikoe5a9RgcW4Q8imnDi
         sAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747926345; x=1748531145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfVvvdWGG0adnBwzws5Hqth/btOaihCNY1aQF7gASIY=;
        b=ifTZZYFI2xAjgZ/pZ1MM0nEDs8TfbOmUD14KnzoXmwcBWe7iolqHroyycQrOrjDVvC
         /haw+9zWtBVVMm1aHBjIbvs8O4eLqHN4RokHmdrKuE3Ef9n5CP6AlsGlcsluUNqedT2L
         t0BjeVBf9L/AJvCYZoGdr1UGbPRduHXCh5o6DYs2+2o+C2cwj561S6PiGWNAVOCCXDp3
         75rqrJLJToFX2HHdPjQl5HnU81oU680nNoL+JJ3KtBuQ8973cLx5sBgg/aHbimA8H4Im
         XWqkrYkO3oGmqqeZ179RvtT/sRTeSBJ1jOO6+e5vdYIfswpqDmT3hLW+/+tYOGWiv4Gn
         nPYA==
X-Forwarded-Encrypted: i=1; AJvYcCURSLU2kR3yqC6aMugi2oXQPDMZpIqbvfm52hcfgpRtipWOFPtAkITd63o/ohEN+d2nOE3Xx5a6ul2/81jQ05E/gHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuJ3AAazgQcOdRCHWZqtmaXbIQmMjZj/5uLNUc4W6eVZ0CmXc
	95C5she1Ebi/JZ9QilPUn17dJ46Q2I3IwJZ1qa4G8EyQyATo6WPIeF5gMYLBqUZQvscSJ9n+906
	ud7gCvpOcUz46RuVsxNssdxX1tzhmBUN/teXu5IL0ipJVRm3POOWF
X-Gm-Gg: ASbGnctxYxSIrAuNNc5WlF97DyBX7LW0czZIY17+jJsDG3FMeujEWvT8DNt0WZv4iyh
	kHvYIoxFQyEwTI0mxlg1rvQE5V4OczKce9xQO2SxJceVIJd3kOVt/iME3LWsDFBJKmnuBmI/Rg8
	GzuM0866lKENkHkR70IFqGh3MAdhgmRpD4NUklbLBmUkHU7I746QOMuc2BU8zamg7oB4zh1BB4H
	r5AlK9WDI3+VpMtQf6/BGy7K0d++ai6pxE2n2aV/lqxzga0yaf6fpRvtNjLDS7kNsLpw4Dfl9lf
	Gw/mQSj3/EnQlv4x8FHstcgCKo16zQ==
X-Google-Smtp-Source: AGHT+IEYt0bFnFpqhd2H1XnceM8lYVhuAHUarQy8gh4pLinv73lfLkgJKvqyllIgt5EGZDv1rrVoDWxaCb89
X-Received: by 2002:a05:6870:fe85:b0:2d6:1e7:f583 with SMTP id 586e51a60fabf-2e3c1b8e07dmr5370430fac.3.1747926345338;
        Thu, 22 May 2025 08:05:45 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-609f2fbf362sm587638eaf.12.2025.05.22.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:05:45 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 90DE9340286;
	Thu, 22 May 2025 09:05:44 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8A9F5E419EF; Thu, 22 May 2025 09:05:44 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] trace/io_uring: fix io_uring_local_work_run ctx documentation
Date: Thu, 22 May 2025 09:04:50 -0600
Message-ID: <20250522150451.2385652-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for the tracepoint io_uring_local_work_run refers to a field
"tctx" and a type "io_uring_ctx", neither of which exist. "tctx" looks
to mean "ctx" and "io_uring_ctx" should be "io_ring_ctx".

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/trace/events/io_uring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index fb81c533b310..178ab6f611be 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -643,11 +643,11 @@ TRACE_EVENT(io_uring_short_write,
 );
 
 /*
  * io_uring_local_work_run - ran ring local task work
  *
- * @tctx:		pointer to a io_uring_ctx
+ * @ctx:		pointer to an io_ring_ctx
  * @count:		how many functions it ran
  * @loops:		how many loops it ran
  *
  */
 TRACE_EVENT(io_uring_local_work_run,
-- 
2.45.2

