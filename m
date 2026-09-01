Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072343F4A6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278096; cv=none; b=dmC1bsg88OPs/g4hKX84fgUN5S6bpD+OIqLkOPXb6wN/IhXkXo/r8grFn52CA1AEPcWkGEyjQHa1jw252yjKFKyViSSFmIMLqvxsJF1oRJwitVhpvmBjtHHlE2EyzJYiiVdLBsfp+U7gskP+/CDY8Ba3AfefBiq4f+1jJrkn8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278096; c=relaxed/simple;
	bh=zuja3xdGtmWolyyOp5Lht4+r4a2fV671B1BwSQW5ZG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NzHsuo372Ys2UEsSIIe+deaLDlMxbX6DF59K77MFpM15oWQRpkX4VC1mymZhXJJV/8dqgucd9eRUbxO1Oxv68YjEMGpW4//KCXdSdQ4OFJgbytNsOcw3Kp5YAJUQNXcGSeW8dlTuTWvyKoaNNYLORvnzI0dfCocrtsaq3/nzMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEK5aUYL; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEK5aUYL"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso9959995e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788278092; x=1788882892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FsJpjMap89L3xg0Jo/p/SVRBiaT1jMUIMpNMGOQC0kY=;
        b=aEK5aUYLWMKa7kwbs2b7Lg2IrzwsslTxgWzR2sV7876ACHoCVt9kEi/Zf55klxsbf0
         zzApXEIZ01BJKclGms/gLl/9hBTwro6axxqtVhSoyoAk0uQamQeunUxyaLJmwPN2ckWe
         EjZGcZcH8TNBWgzJNmhV1utDavhlQQVIUFBDrp4tBscbyv743lQKPMDacywvq/4WQt31
         6Xa+3yXfrR/rOiFaIBa4RmUU0dFrOmyQzf9PhiHh3bdr6Am2mJo6uxFc+W2hTcH2truF
         3eMKC+4hfl5RfRnPI3FIEug5RcpMfcGj2fOYAfv9C4tKOwPn8aD8pQyd/a6Hwdbe5LQQ
         9vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278092; x=1788882892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsJpjMap89L3xg0Jo/p/SVRBiaT1jMUIMpNMGOQC0kY=;
        b=IKRljnpCgX8svgDCNsEH70QYjjNYKqufzCP3jTQhhRRlV5eKCIKRAviirGThYWnB9+
         HlhDjp0GKq3z+Puyiefbr1WPYQcpX+TRKXVgs2jrOGian4PFTHFkER7aNiE1MZIT9mdc
         FVj8Mbt0/U8hoSPFKUKrwxJjBTnMPIOXSd9NViwj6RwGCvB9FfBtvvVx+OyMcCwYweiW
         j1JWQmUOGShXoADuKO09mnrCjYMUIpgPjCj38ny1zRpLfugXDsNq3Q+QYDfITy9cSiXJ
         H4HV4f0eZw+XdTYFgFovBtS1xMVTYy6Zmq3NJVl74cwmOIUa6amMgyG+6chsSiftVoER
         ie1g==
X-Forwarded-Encrypted: i=1; AHgh+RqCY0+bRSSYRl2JWm8AkxfymEddkRXxdTgje6F1vvsOOOEOorTUTnoqJEh9YMilCTcTwitw6n9d/Rx4zfBsNWlfguA=@vger.kernel.org
X-Gm-Message-State: AFuF++n+Zxs3D4up8PHSOFnxvtMPS7olPmLZRMGb1MoOzdINt3n2NV6M
	tGjsmsPIZSUyLnSHdMy52KWjg52vaG9DLbGnBH1L0tDgIp92y5B/YpJIniwikiyup9NMhSs/qta
	avUHBgLJHNthHlR6bb8jW4w==
X-Received: from wmbhj9.prod.google.com ([2002:a05:600c:5289:b0:49b:6a4f:11f8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:10f:b0:49c:e3b1:d826 with SMTP id 5b1f17b1804b1-49ce3b1dacdmr20137095e9.13.1788278091873;
 Tue, 01 Sep 2026 08:54:51 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:54:42 +0100
In-Reply-To: <20260901155445.1475405-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901155445.1475405-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901155445.1475405-2-vdonnefort@google.com>
Subject: [PATCH v9 1/4] ring-buffer: Allow splice reads on static buffers
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
2.55.0.897.gb25b4bd76c-goog

