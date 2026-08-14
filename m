Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13F426D0C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694363; cv=none; b=pk7TlzyKrQA4Phw7mNvKChPpVXR3kYZbzS7n4CLDaqaM9VnBAkdCc2xZPq6vxIiYQV96qx4MDVl2pZI/QyRpmQswJ2BLexc3m9nBwfANTO7OhAZmdxBTm1CigWsmhECcIgC0FPfPcsu2i5GTiFzK2v+bzgc6qiYGdsBezklV+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694363; c=relaxed/simple;
	bh=lFuuVXygboDHCbUA1cBZ6s2e1iwH79UL1npuRt7IJDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP3Z8J21XANebMKv+79obShJ8AP5DNrpknudoXx5ZgffpeKkOY4bduYAwtDZvwhYho2Mnr0+AUMRlV7L2jocb1UvSlFDwkqP/yjLr5nlCjk1x6ihEqgjPwKsb80QwxId8NU++Wab1CcOKO+I7I3gWi3RJcVpEOpLtRIzaqeeGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2srPoFy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2srPoFy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fd66a094eso254172f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786694360; x=1787299160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SQfNyfohuDdwICs99uq9OSV55VdM81uNBvlCVq5GtNY=;
        b=G2srPoFyL8qVhPyz2lHteonanOEtpVv2oUSg8MbjTgFV4KbGFZbLVzNPWm2Dn5zisU
         Ow04PaIN6E/xYD5vQ5GrYPUf3t4bM3CyCyiFzpooFAucJsldNBv77FrX84SWWy3R4L3n
         CSiTRHMIn9T+sr4DO1GpdzUmt1cxsbWP4Ieneucw2T30tV5A3t6Gu+RjRs1ZHWRSA7kz
         h5MLXzLVquN88NewIyo01acLE0+NpSZ16jU0hOW+wRxX5jM0VPshHm9c5J/DB/uN+HZD
         RPGIDdg0sgvO/vYsySHmZaGpb4lKBExShHtpdI1oryBmK45HE/eJ82VnIKSIR7mJluUK
         Sk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694360; x=1787299160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQfNyfohuDdwICs99uq9OSV55VdM81uNBvlCVq5GtNY=;
        b=icHzUWl5Na9SyISPo0PjYz3ONX3QKKkGFsMX8DV/0iYm6aJPkhYFfNfN7WB0xbXDTA
         //rUXZYzABQKYihdenaVHgUoaDJUEKWZklArdxc4AO4vnyE0nTkOmKJhfovMaOHwnm94
         y6h4Dj9CDrEJDk4N1VbG0M+380HYOEIv/f3hohNyhF8MtAgBXYzsDR6Ph15djYl52rj1
         +tf1qC/biLHpw/tSFwqExKAidcb6kPaEyO1E6T4RxvG2ggSecdiahbjJcjyKu7vfwpLI
         CQ1GScA0TJBulsrBP+WWANo4n5AcWY/SHCy+6Q55srUV1zKVOxdNExiVRA96qUqnVWXE
         EJ1w==
X-Forwarded-Encrypted: i=1; AHgh+Rry0hdXh8SBI+/HpO1rV9AgWmaGWEtTF/G23ZmcgvZa2/aWv0trjFSa3JQsoI9mDr5JiCMkT0k+KvLr01X5viUHSEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcmivZEHhng3UpaKQpGQ0xD2Zuv24qtjWmD48wOkXeC8YTvRI
	rX7rVCgqobiksZpNGFid3AS2oxNFRRnJGsAjPg4WV05qkYaMUACxiUbl8yTdggvNHg==
X-Gm-Gg: AR+sD12u1lxrE5n8k48AVVk19yEaCMjXV3EsfLK5IYM1g/NXGAPBSuMlL54455gzQ+0
	IWoI/XkLa8xb9aRfuL1mn5lTeqtWLjPWsS8ZNwCcdXWeGuLFqRejWN7Vq6GAy473q09DZvkgWhX
	2qR8m8EryNe7YZTJufXqGOLXsWIFIA65p/6ymCpV6jGnf0VfBygDLKQcRSlGLRS2NajPawcjAY1
	xXdPhqepsOgD0tkODpEgsYBINbV0BikpUKFWIIKlBtkRJXcrZb8Q6PhfF5L3rsLKfir8drkRGWe
	HJLxUFCRjCs5MERJeXE8sDZwbpDnL+mBLgh6jc6IC0lNQGNdxDB3g0/mMkEPoFGgkoGdoUkC8Fl
	jPavdvaTXIFQ31Fvsq+tcvFaO9kGWtqImJixHKcqlgZp1C1ghp9iuN5POqRHG1ZqbW/u41yKN2r
	tkQPdJCQgh+EX5CISZtgIEQKHIT2keEdQoOrZmZiKEz75hdjOqZ2k0lT+gxZHx5RVZrZS5usm+P
	4WySatEIFEBbciPhJWMW19a+xXZzTN0
X-Received: by 2002:a05:6000:2301:b0:47f:9096:3ef1 with SMTP id ffacd0b85a97d-4816072f9fcmr5926592f8f.9.1786694359519;
        Fri, 14 Aug 2026 00:59:19 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b13c3sm4863145f8f.19.2026.08.14.00.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:59:18 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:59:15 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/10] ring-buffer: Dynamically calculate max_data_size
Message-ID: <an7K08bEyc70erD2@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-8-vdonnefort@google.com>
 <20260813213407.6bc29cc9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813213407.6bc29cc9@gandalf.local.home>

On Thu, Aug 13, 2026 at 09:34:07PM -0400, Steven Rostedt wrote:
> On Thu, 13 Aug 2026 14:11:49 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > The ring buffer order can be dynamically modified and temporarily
> > disables writing to do so. It is therefore safe to use the updated value
> > to calculate the maximum event size which can be written onto the ring
> > buffer.
> > 
> > However, notice it is hardly making any difference for trace_marker
> > because of the TRACE_MARKER_MAX_SIZE limit. For an 8KiB subbuf size,
> > trace_marker can take 4096 characters while it can 'only' take 4054
> > bytes for smaller subbufs.
> > 
> > Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> 
> Why the fixes tag? What is it fixing?
> 
> -- Steve
> 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 

I wasn't too sure about that one. Let me drop it

-- 
Vincent
