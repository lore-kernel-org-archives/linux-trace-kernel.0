Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E3200108
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961598; cv=none; b=CjbH2MKgNJV+SFjBDI7OiEYyRLoP4QGUNlG0Tbutc9HOZAn1OQoSgU68AbSiLSYrKTpglL1vpSxZo/YOg+2+pYIcxLjtxqIDR4wVuMD4gtq0RzPwv8LUFF+Dtr96ztZK/Zl1MGDMzw0hCsPhq7Jv1QLIgY72nk+DOwGxdSfa1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961598; c=relaxed/simple;
	bh=9iUNtBBTrhjDotYpsJ4A1kjabcl4g1/BapYEuI/nJtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgZRFV/cRUS9wXpfkIsIUfQz5C5r9R2gH2I52n7rI7Ljc2D8Dqx5fABHdziMPJWmBkv+Eib+TU547Mn/MkN/GVgNChrWtbUK9BAHlRGc0lLuhgkCethGkotChvDtNyDRUPIjxfbdFerXyePCR4jsVLWDTZC1bFWYKXXe0zxR81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FtOUxFb1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FtOUxFb1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf848528aso20485545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741961594; x=1742566394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ev7Ui75IuuSIPWk86Wm5e6FobvO+1G5BN5BqKHdtAI=;
        b=FtOUxFb1SGuki814z5Qg5vHv7vUbxkyp0uZmnX3DfSWRa8KMf5CVVR35LDHs3PsfA3
         YmS+csNjzHnXuyqLdqO8DbeoFJYdJMhL8S0Iqm9cB6oxLH9i/xGhHTPwISGwrRoOmC4L
         KibCY8pDqMdkiOXY9ouzsmj5KMcKIziV18VCnfBsf/Ok/fex8jhiORpUFG7qtPZaSDQk
         cLoJ4jcRAWzX8Q/9KJVJtKc0YKq/8rQRN+8k3PS+Bjk1RQCtN0HeyXmzTLtDyRHrTRMP
         9NhY2YIYqUtLvFitMMXDGoRMc9GfVXIgC87PRtGm1w9dSV3W98kT7FQESn1n3v5yrwNT
         YNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961594; x=1742566394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ev7Ui75IuuSIPWk86Wm5e6FobvO+1G5BN5BqKHdtAI=;
        b=a/bapVkmXHlKfNFAIh5lHvNvNZd5Wylk5oR69bNop2Jk8Dkw/MqcW9Xw5JteQ9pMHQ
         t29mxIqyuQ95CrwU5Z4mLwfPXM9sE8KKIU6ohafzLWhJIXSXxVgj8/WBhCN1a+vF/RJT
         mci10DTuh9qU/FsPxaGc31S9GLwirK9oIFY6sQxYYvITsiRe3R9jMGmh6u59dX2jLm8r
         JuFsZiZxZrpk9uJeM1i3cJUpfS3klZMfjpMm1aRqBnfA7MQqgPsOBQ6abVVKDc7B52JU
         QJFjpkOKTTa6M93V2FItYqcWpX7I3UwJDm6VSVJpgm03fIcFLgevudo1qdPelsDikmNn
         0kCw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Yh7NI07loTP0GGrwEgbHEMRqALldfPw9N6B0utl1zDdmBDuqq28Phb+ewe7myaImR40cYNVKyn8aYd+uYdntfkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU34dVisnnCxHyYnQrpm+IOV6a+L7NwM7hg+WNAaoEAl6wLc/f
	jA8f1u7xZ+l7qGTJExpkICvk5LB95QuFasm8knxWRZz+leGIIce45v73wXT9U+k=
X-Gm-Gg: ASbGncuMaaA55dyW/m+tDtmsXnbXAkQ5S34mjzI76l9uorxjcUCj642l5W4K42ip0Lf
	Ul268yI880jN4CeOb3223gxgFoqaDRnVhs019iKJE1QT8hn3zfcLiglqj/h+/QQJXztPB7lg58p
	VnzLxqOIl0htJlSdFYVRqHkYdTtMR71EGekU/WVto0OZ6SVJhmhbWFIsGkuZ4xJAMbitKC90dkZ
	aAniIjXmezaHXhVTSi9qCNj1FL4+LyIXB43tZ5SsVD+f5MaDfLIgyz6XU4xWO7bJAylaAfw/IeT
	GSJcR/S8LkEeM4NS22qGsVlPIRO/ZEMCghpG2KELt4zgSxshDQidfpfjeA==
X-Google-Smtp-Source: AGHT+IHwozIbGl0OHOmEZQ3S3NFp6KYWrzBJ9oVTGXL5DC16G6oKXkM7tqtYNlSXL2GE2j1zPhB1Og==
X-Received: by 2002:a05:600c:1c86:b0:43c:f4b3:b0ad with SMTP id 5b1f17b1804b1-43d1ecd0f21mr32888105e9.19.1741961593813;
        Fri, 14 Mar 2025 07:13:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df34eesm5761373f8f.18.2025.03.14.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:13:13 -0700 (PDT)
Date: Fri, 14 Mar 2025 15:13:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: gfp: vsprintf: Do not print "none" when using %pGg
 printf format
Message-ID: <Z9Q5d11ZbA3CNMZm@pathway.suse.cz>
References: <20250225135611.1942b65c@gandalf.local.home>
 <Z9L5HsVzQ0bVZtjp@pathway.suse.cz>
 <20250313125313.4f3d98f4@batman.local.home>
 <20250314082534.57ef07c4@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314082534.57ef07c4@batman.local.home>

The commit ca29a0bf122145 ("tracing: gfp: Remove duplication of recording
GFP flags") caused the following regression in printf_test selftest:

[   46.208199] test_printf: kvasprintf(..., "%pGg", ...) returned 'none|0xfc000000', expected '0xfc000000'
[   46.208209] test_printf: kvasprintf(..., "%pGg", ...) returned '__GFP_HIGH|none|0xfc000000', expected '__GFP_HIGH|0xfc000000'

The problem is the new '{ 0, "none" }' entry in __def_gfpflag_names macro
and the following code:

char *format_flags(char *buf, char *end, unsigned long flags,
					const struct trace_print_flags *names)
{
[...]
		if ((flags & mask) != mask)
			continue;
[...]
}

The purpose of the code is to print the name of a mask instead of bits,
for example, printk "GFP_ZONEMASK", instead of
"__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE".

Unfortunately, the mask "0" pass this check and "none" is always
printed.

A solution would be to move TRACE_GFP_FLAGS up so that it is not
the last entry. But it breaks the rule that named masks must
be defined before names of single bytes. Otherwise, it would
print the names of the bytes instead of the mask.

Instead, replace '{ 0, "none" }' with '{ 0, NULL }'. It works because
__def_gfpflag_names defines a standalone array and this is the standard
trailing entry. The code processing these arrays always ends the cycle
when flag->name == NULL.

Fixes: ca29a0bf122145 ("tracing: gfp: Remove duplication of recording GFP flags")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/trace/events/mmflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 82371177ef79..15aae955a10b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -101,7 +101,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_DMA32),		\
 	gfpflag_string(__GFP_RECLAIM),		\
 	TRACE_GFP_FLAGS				\
-	{ 0, "none" }
+	{ 0, NULL }
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
-- 
2.48.1

