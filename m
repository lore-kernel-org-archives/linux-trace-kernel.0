Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D32169AE3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709078; cv=none; b=oeFS6phl+q8/TZHcd33htzKdcVn79pQkhH7iPeiZ/NrTGAPQchwD8PvVEpXs0yuElguXkkYwujrwW4soekFbEU+eP1ulq0FBqzISrkNVNRgPYFYDr9BMkEMPSWyuS4Z/g2jGC+3DJZ5Wvs+2367Fuv+OnC5QFs+OHeDDn3oTWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709078; c=relaxed/simple;
	bh=MMu6kiGgrdyVeIGgo0o2g5ISXoiklOJgpiyd0c6Mhcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCWxO5ltvvmUYd1cKIezGcfprAjH8VCK1MsRQPLA2TMNGHSSLPTaXNABOERnZGbaq/UVZ3PAw2UEq7pm2hqk2PSoEhPjti2neDbIA7NlxFMuPwP0TbB1VPpg/Xp9qN7nRr+TMrmtT613MP0IvwuvoXvVdnSwEueH/BPjx+t442M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=q1PXf1Gy; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="q1PXf1Gy"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b3655297aso9071477b3.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720709075; x=1721313875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6PLNSJZMY2HBtPFlfBgNDPZWDEOAS/uY6eb53FVzXU=;
        b=q1PXf1GybYh1aDXkOQriXh3etXHQaQvAEvEHvmjzflwesjMtmTkIcKjsvkM3cvyMew
         1ADOSrKUCZeN1Bc6ndt1rYxk0DDfHkzu9xezqPuUzubgvhJWQPvuMkrPn/0U5ZZxfo9i
         fctEzUyU1X+gwXWNkJGT6Qb6Rul3J21Wfk7CiQmTfo+8/rA+YGP6qKw6dLORH3DeagL/
         y8faZ8jpGGnpY3BUumaQJl7BBvPzevdG9+6FJ6dQodNUGNJSp/gYUNCG5drWdvmjx5Mn
         cv8yTWT0bLgjhtN0Oa3FCF0hNCixvqUBhriTBD67tVMd36sVAEQFtLzVdeP7ReM7JUpg
         nXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720709075; x=1721313875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6PLNSJZMY2HBtPFlfBgNDPZWDEOAS/uY6eb53FVzXU=;
        b=cXwyDBRiSDCWeuiM4xzpUFBvQsc8vHzv29yAT7lFarKRRj1ukx1bKSULpWjvTsUgFV
         onXfmBrsiQjdMbZRiVskoBnojBsHV7jvmGS2OjMGgN0pV82mBK8SJjmPsuDQEDT21jOR
         GxuZmr8/FOEjd6tz08X60b2HlsGLYUmbrLOts2ScyD1KBKZZ8oCMMvIR2tSQoutVCqa4
         DcDE9uJVJLVYREIIgt5dAeHkpGYSda7gSTYzi7G0Z3lQ+6+FFCmrzJY+WIRuGTqz7PaR
         /DZQYKWS9EFa/k69WMUpXXPh57kmw4F+KWW1Rjaxfu3xdDD6kGUVv7mwlif49v0IPzQx
         0RKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu5k/h3gXDST7PWwxapYdRT5EvUvGG9nq9DWI5EKhgDcaQBH6R5n5syuzIMrugKmphdzIhPaAV8tWLpHRr6j39dLXTiO7UwrtZza6R9bCbjbOQ
X-Gm-Message-State: AOJu0YxY52nHA6M1mPv4Ql3yh3349cKFpJ8EDp2QSi/DNHtfLg1rhmz8
	1c9qnl1MRZL7rWqGgnLr1j1CTN5WE74jjcByhmoF8tfoob0aiVVllpdGZwW5VRQ=
X-Google-Smtp-Source: AGHT+IFAnEDVnsGx1tZ1AxBo1QTn+tOSC2MfALvNb6Q+MllvTQBzHLMq8T3kjDK5yp3+1lqcT3GiRg==
X-Received: by 2002:a05:690c:3385:b0:62f:2553:d3b3 with SMTP id 00721157ae682-658ef3414eemr120805467b3.29.1720709075414;
        Thu, 11 Jul 2024 07:44:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e4936079sm11198567b3.15.2024.07.11.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:44:34 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:44:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/9] fs: multigrain timestamp redux
Message-ID: <20240711144434.GB1235314@perftesting>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>

On Thu, Jul 11, 2024 at 07:08:04AM -0400, Jeff Layton wrote:
> tl;dr for those who have been following along:
> 
> There are several changes in this version. The conversion of ctime to
> be a ktime_t value has been dropped, and we now use an unused bit in
> the nsec field as the QUERIED flag (like the earlier patchset did).
> 
> The floor value is now tracked as a monotonic clock value, and is
> converted to a realtime value on an as-needed basis. This eliminates the
> problem of trying to detect when the realtime clock jumps backward.
> 
> Longer patch description for those just joining in:
> 
> At LSF/MM this year, we had a discussion about the inode change
> attribute. At the time I mentioned that I thought I could salvage the
> multigrain timestamp work that had to be reverted last year [1].
> 
> That version had to be reverted because it was possible for a file to
> get a coarse grained timestamp that appeared to be earlier than another
> file that had recently gotten a fine-grained stamp.
> 
> This version corrects the problem by establishing a per-time_namespace
> ctime_floor value that should prevent this from occurring. In the above
> situation, the two files might end up with the same timestamp value, but
> they won't appear to have been modified in the wrong order.
> 
> That problem was discovered by the test-stat-time gnulib test. Note that
> that test still fails on multigrain timestamps, but that's because its
> method of determining the minimum delay that will show a timestamp
> change will no longer work with multigrain timestamps. I have a patch to
> change the testcase to use a different method that is in the process of
> being merged.
> 
> The testing I've done seems to show performance parity with multigrain
> timestamps enabled vs. disabled, but it's hard to rule this out
> regressing some workload.
> 
> This set is based on top of Christian's vfs.misc branch (which has the
> earlier change to track inode timestamps as discrete integers). If there
> are no major objections, I'd like to have this considered for v6.12,
> after a nice long full-cycle soak in linux-next.
> 
> PS: I took a stab at a conversion for bcachefs too, but it's not
> trivial. bcachefs handles timestamps backward from the way most
> block-based filesystems do. Instead of updating them in struct inode and
> eventually copying them to a disk-based representation, it does the
> reverse and updates the timestamps in its in-core image of the on-disk
> inode, and then copies that into struct inode. Either that will need to
> be changed, or we'll need to come up with a different way to do this for
> bcachefs.
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20230807-mgctime-v7-0-d1dec143a704@kernel.org/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
