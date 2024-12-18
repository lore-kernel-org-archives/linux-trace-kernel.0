Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB01BEF69
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532299; cv=none; b=hWHUydP1ZiByNXw6EFHrGYaHwqKXFAAOKv9D+YaLASPY7oqAkM5YsTga4/YiurWX2DRAT8nopGDtShG5B/LoMaBi2wQxfaXMPAJtbhn2Hk3gOebF79drkUfQ6U3Tw9KVMMUN4OLg190wY9HhS2dj173przFA/CmwK4t5sKQ32+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532299; c=relaxed/simple;
	bh=icb1sSOE6N18hcVvjE4CgFX/JWoWPR7m038MZxQhArE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDcoIf+Xmmv2hdq9/S7++BnIykI9YL9dgU0DRi23N9oMhqX3H6RQAWeg0CqrZtHrf6KYbrlJhb9Fh9A4urbQJFvRhqFHC4adY0UZpPkfP4nbj3PNN1/yBaDGN+EuAL+MLuDbaleCnaABd9zLTez4rGGp00pMSRM8BhWUfckoAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOoFC51k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOoFC51k"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436341f575fso53188405e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734532296; x=1735137096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8JNGRdv9KdGTXG0MjRwkStjcXaUgTSrflapakuu2Us=;
        b=eOoFC51kqbgB2dK2y34ukRBsXFVm/Oy5ieBBx2+Z7R48o3RegfwHnTAyLVsFxLgOqk
         AZXs2HCPzH6uJDVZ8rhueSr30JT09nVAvsq4a/jtiTji2+/2ifdUUp99c9aWywwzceJc
         xMGK2njZpzOmfgo4DMbfclXilnI2/JLykS9nkWobTlmZP4gnICIIjMS2hMV1SRq6Wy3E
         51zR4Zy0bV3xf47LuFJKE5lLEuWmqyfBPhfkhGZDNI4L5AeLZReGG7v3L/O6B9eWRb8I
         H9puXQlcmcuzXC213ql9viy068l12zFjSJIc4iUuVJshoPzwGimJlWSL3ArWiN0TlZ+R
         /cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532296; x=1735137096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8JNGRdv9KdGTXG0MjRwkStjcXaUgTSrflapakuu2Us=;
        b=t2ZnEXG6iVnD5T5i44IehS+JXPA6vEdysmZPSp7B/07mwahNaHDjaMbuGVekctvC0O
         zTc623NmiIMZ93oVnNRQLMVnxrENdbHmXZBrWLNnEtqdlbQbnVHd93X0+8+YEvixlPn2
         xNlcqYUNr4d2K+P1HlPOp8NLd51rNPFgpDt07kLXA73rr3EYVVATkh2qERdmwTXXC9Yl
         IaUG+nfv70DPWCq2iImkzBuGYB4LDRtFO1Wd2eGhlM8f2Nk4ynds8HAn2GCmkYMqtTei
         i6Rsc41h7mW8YImg5AoAXM2kRHPsnCQe4VTxyYgRj8Rcscvq6KIltCKbxcLy7Atss5Qb
         UI1w==
X-Forwarded-Encrypted: i=1; AJvYcCXX+9+raW+AXQUcUR+buJgetvTJzsmZ/xEBRelrHW1GRJVKTL8iR5tXvjQHbNqUL3VpqxpkbOgTugJxYzYPgIkQt/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCQN4dfmQZEzfpWI8mErKUgSNLnF1Bw/mMe53r6kjYjdP7uqJ
	K7jN9zYIgXPbScaiV6Jk5AKCBqU47Eje+fSoBz2bR11z3H9Fg+KzUQGnWDG7Rg==
X-Gm-Gg: ASbGncsNprVUNd2anB+s+0MIHzmiVyXxev8h3xOMKSKHFhc5cPmSwK2B49r/2vrug74
	bOfgv2H/3LPBTfniGn22zbf/p0v27JIJx9YUtanLFs0ZNKn+Uv2e5SHEuxM3mh3kYpl1bUM+Igb
	3mjWzI4yur94lUkOF+tBMosg+3++bVoTPYti8UPtb3tTALP3VqtitoA2aOGyvhz7k91QL1MVIrd
	vEJ9dg+fH9EOiQ+aWZB7COZZUfB7GMyU3SYrP/bUpv2ZZzdnwdSHRX+Xi2JWPv4ln3mNDRF+4vJ
	lhHhLFi+suat/zfIzL7/QA==
X-Google-Smtp-Source: AGHT+IFBcUlGwPE9lSKPi+6Y2zHNtfMZxTXAKFzbath23Y/2nq8MYnGnDDgnHT7gNNduj2UTvKbpUA==
X-Received: by 2002:a5d:5f87:0:b0:386:375a:8322 with SMTP id ffacd0b85a97d-388e4d83454mr2866207f8f.13.1734532295589;
        Wed, 18 Dec 2024 06:31:35 -0800 (PST)
Received: from google.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012042sm14209781f8f.20.2024.12.18.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:31:35 -0800 (PST)
Date: Wed, 18 Dec 2024 14:31:31 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Edward Adam Davis <eadavis@qq.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>, david@redhat.com
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Message-ID: <Z2Lcw0StqsHgU7E6@google.com>
References: <20241217124602.2d498c3f@gandalf.local.home>
 <tencent_4F9EBF1BA54B1A1B74257CBA08BB49334F08@qq.com>
 <20241217194015.7a4f0dc8@gandalf.local.home>
 <Z2KSR5QrAWYDEBVh@google.com>
 <20241218081958.55204fb3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218081958.55204fb3@gandalf.local.home>

On Wed, Dec 18, 2024 at 08:19:58AM -0500, Steven Rostedt wrote:
> On Wed, 18 Dec 2024 09:13:43 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > And probably also 
> > 
> > Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
> 
> I don't require patch submitters to add Fixes tags. It's more the
> responsibility of the maintainer to do that. I still have to validate it as
> there's been several times someone adds a Fixes tag which wasn't the right
> commit that it fixed.
> 
> -- Steve

Ack.

Aside, there's a selftest to check for the overflow of subbufs with the
mapping... but of course it didn't test with offset > nr_subbufs.

Do you think it is worth to extend it to cover this case? I'm happy to do a
quick patch.

-- 
Vincent
