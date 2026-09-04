Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC950AC28
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540372; cv=none; b=tTAP2QtWM49191GhNJxJd+srCUFCCUnbGtUvFKnbD1IvsIuexJSUe1nytoRIdk99t2GajrPQ5iReb55J5FKEMgoPMu3GTqkrOh18wlSoDV/8t/zHHJzwoGNp4EAXH7ewE0rj2rheBv/CriAGg4cVHkNsO0gnW2WGtdYpGoApjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540372; c=relaxed/simple;
	bh=hxQZMLwG6yecstcTEMEbqIUKya/zeWZiCbghCJI8fVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGJXJIAZgVv+KcuDA4F8jl5Y2t3Nah8oXOTxOBksjsgYQPp9EXLLS0/hzmTsiPfFfz04LlJnlw7GDpz5Ikg3/QxyyvzFJIJ/7ppk49rVChDHCLdvTzNVIJCMrfchOab059p0NxfZ7xoeK1xZRNnWIldHDOu10SmXe9rA0S0cZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpkXyu6U; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpkXyu6U"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so9389675e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788540360; x=1789145160; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWNAdrwGmNJRf6eRTL3iblh5LCxPTOBo/qfLWNuuaXo=;
        b=vpkXyu6UIvcaSzsDleZpo1eGIF5yY+lTSnOrIhzO5QZNnnGlE05girF4gH4JixmfzK
         50xri6fSK8PczTnr6MUN2GNZ8+fGTML/jfDv+s5+kKvZ++wKj7VArYmCwBJVzY6ok6dI
         16uDI+uTmP0Yg6KEbmZgB6sHCemsYvLIbjQB4shpHvkoH7kgDoS2nOWxQZEH2nenm7E+
         3BiM+0fozaacAidqi66ze+841KgVSvmBfvFH4/XaAMuhhVkqchiR0xAUWAbIZzMWhtfe
         uABTOB/sIUCEkBAEiLLLocP8WBfBR0Pg6ItcfjHhreQXKjyE8b5B+xLeqVYHbYrjOjgY
         io0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540360; x=1789145160;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWNAdrwGmNJRf6eRTL3iblh5LCxPTOBo/qfLWNuuaXo=;
        b=inqtNwyVInOfTgMnN5DskiCXgCujbm8jBW+H5auOxYv6rT2GezGOKFYVgesr1/xy4c
         WKhBmfTIJnl0FCkWzyaoph78HniD846JHaMTwYN4cA7igycJPJzwuzUFLxzhVTi3u6qX
         ylgFXeZRo/rvAS5YZDUbji3siPcNI+X0M42zlth9EbK3TsB8dbcfuDYB/bfmCzQYwEIO
         cH8MeBhtc9sj0v/e2h2UZOUzUg34n2VBkL1rfV1tM3QXeqW4XacQWICBh9Wts/MDESoj
         13Bij22qUaYH5/lET49cxeAXkt7HrRBEpZDu8fIzK5Bl0kY252B7R+45+FXbt+KLvUHG
         USlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDEM3x0LO/k5nYtm+N3HP7KRZABk8Rb//pnSUys2o1qCfqvgTyYxD3NTg0QA4UtThHQLvhc5P3BSmAYiwXD/aLbog=@vger.kernel.org
X-Gm-Message-State: AFuF++kIkH41pbMDdx2EU+LF1fdBPUD2LcpF+4AmnLaHe2zQPNpG7Fo9
	9Hac2vjETCEiEUwNARqNoKqRJ+nsMGO6UPnycR+L53pdDBVYG2O0uv0IhkkO+DXWadoP6cG34an
	CHfwPJ7izk0Gzu2QVHHnlug==
X-Received: from wmwb5-n2.prod.google.com ([2002:a05:600d:4445:20b0:49a:1b4c:be])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a40f:b0:49c:fa21:e74b with SMTP id 5b1f17b1804b1-49cfa21e9a7mr42587355e9.33.1788540360049;
 Fri, 04 Sep 2026 09:46:00 -0700 (PDT)
Date: Fri,  4 Sep 2026 17:44:47 +0100
In-Reply-To: <20260904164450.1345852-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904164450.1345852-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904164450.1345852-2-vdonnefort@google.com>
Subject: [PATCH v10 1/4] ring-buffer: Allow splice reads on static buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_read_page() rejects splice (full=1) reads on static buffers
(that is user-mapped, persistent or remote) because !read check assumes
unread pages must be swapped. However for those buffers we have no other
choice than memcpy the data.

For the memcpy case, only return an error when the writer is still on
the reader page for the splice interface to wait.

Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b0963ac6fd16..84fd4cdd486f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7193,15 +7193,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		unsigned int event_size;
 		unsigned int flags = 0;
 
-		/*
-		 * If a full page is expected, this can still be returned
-		 * if there's been a previous partial read and the
-		 * rest of the page can be read and the commit page is off
-		 * the reader page.
-		 */
-		if (full &&
-		    (!read || (len < (size - read)) ||
-		     cpu_buffer->reader_page == cpu_buffer->commit_page))
+		/* If a full page is requested, it cannot be the commit page */
+		if (full && cpu_buffer->reader_page == cpu_buffer->commit_page)
 			return -1;
 
 		if (len > (size - read))
-- 
2.55.0.979.g7e5102b832-goog

