Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07591E7A47;
	Wed,  7 Aug 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038303; cv=none; b=g3aWLqLpWj56tcHjUP3ESdCWYHwwzaERufR1bDY6aJ7QXpDTyCsFAp2QeBz/aUzLr4JkdPlb6ml1KAZbVJH9EHHtOv+mOnJl1yPkp3/KU0oKlU81zKMg4KNjzoh7chni4osLZb8hy7KgaXR71lro1EfOMnHP+MnmL30qAgAQMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038303; c=relaxed/simple;
	bh=0xuQ4iOhDsxhBk/3z5AcRuq999n8AJQaLh+BimCMlw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb3ZrGq6z5NwwHJXn6eU0GjsTyHaT5k6r3n41bg7I7cEr9Oxsr/lHE1Fc+I5UR+uommelKkGhysouDoWi1HTvGg950CUlPYgVHySeCtX8MQTV1sdbP2kj7vO7S99UCSGiBG/ntd82gp+WiSSkB5lb9m26KEHgfqVKKfU85pbefk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PDxsnHN6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PDxsnHN6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+hnoNX97yZXGCx3rbzGZoJTpnmkh5qBJoQ7ckJ8plKc=; b=PDxsnHN6zjyWSjpCALBKZVWkPU
	eID/coAG/TBbkytScXbMlELZvMimEWWVXbtVGDmEpMdYNRzikxJMVOvcLG2gq5pDVKotQS5UxJINE
	C0So1axRuoTs+NQ4Qq3MWEEIfsYceq3ET3K0z+1ifGtmrtCxqKLtGprWkdHTNtXvztUXysS2nLZ+h
	820jbmOuUaVgSRHVXRwHijcrkACe2N1N1qatRF0HmxBFNZ1qOQd27JHK0v4UybrYFNgya0Z4lZu3m
	K+B1/Mdv7GsPbsRlDR/i0jRoa3BqY9bL+qU37DgEvJ8HXx3Ct6Bxl0WlVxjoF6ClqtuASitNLX8lo
	AKKW/nfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbgyD-00000002M29-0efs;
	Wed, 07 Aug 2024 13:44:53 +0000
Date: Wed, 7 Aug 2024 14:44:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilkka =?iso-8859-1?Q?Naulap=E4=E4?= <digirigawa@gmail.com>,
	Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH 2/2] tracefs: Don't overlay 'struct inode'
Message-ID: <20240807134453.GZ5334@ZenIV>
References: <20240807115143.45927-1-minipli@grsecurity.net>
 <20240807115143.45927-3-minipli@grsecurity.net>
 <20240807093545.4ec51d61@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807093545.4ec51d61@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 09:35:45AM -0400, Steven Rostedt wrote:

> Perhaps:
> 
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index f704d8348357..ab6d6c3d835d 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -10,12 +10,12 @@ enum {
>  };
>  
>  struct tracefs_inode {
> +	struct inode            vfs_inode;
> +	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
>  	union {
> -		struct inode            vfs_inode;
> +		struct list_head	list;
>  		struct rcu_head		rcu;
>  	};
> -	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
> -	struct list_head	list;
>  	unsigned long           flags;
>  	void                    *private;
>  };

	Your current variant gives you an RCU-delayed call of
tracefs_free_inode(), which schedules an RCU-delayed call of
tracefs_free_inode_rcu().

	Do you really need that double RCU delay to start with?
Because if you do not, just do that list_del_rcu() in ->destroy_inode()
(which is called without an RCU delay) and have kmem_cache_free()
in ->free_inode() (which is called *with* RCU delay started after
the call of ->destroy_inode()).
