Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE592158524;
	Sat, 12 Apr 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472873; cv=none; b=Y/+xxTrdwEQ8n5Tu4LFDzttYWHjQH91M8n3H7ngDhXMpHeZ2wvqJ/h9g5KAfhrMlbOTMMeMozMNKpLk8bfmlSa/h9/34pjjwLsr7ojqEi7R8RmkVsOUns+5uA6Rqfo/p6KL8iRaiF2EDz+FrqB4kHiMBE0Wv+YFTJ7uaMixu6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472873; c=relaxed/simple;
	bh=po23pYpQTayZdLg8UwY/ZoXRXdbpaMQghpHL0aeA+tE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=io6VP1Drm8b8r4YrjZYw6XoaILAtIfE9qAiDy+naMBempS1aJ6OfEHEwXMb0oTG3qC1tpX7w3VGuboHu4xgbfqwsdJPixYor8X60uKUTN1rs+2qZGS+3E1hfGkRTl2ZkWmD9G56yECNT3FWu8sN4BztN5fJp/TiqHyOBSptaMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXWjKcXg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXWjKcXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E25C4CEE3;
	Sat, 12 Apr 2025 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744472873;
	bh=po23pYpQTayZdLg8UwY/ZoXRXdbpaMQghpHL0aeA+tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXWjKcXgLXMNwbXpNJhlkAwQne92G/JMueDHcaTLKXPj0U98d52liE+KTtskVyGtF
	 7XnKnYo/Su0Dqx5PouRPdbfCc1lpxP4YzIt3OIioK2iwL7GUEZADSUYppS3/0AuvlE
	 fwruCONTbpZJlYCXq06taCLX5R1DZ2LwGB6ppLMjo4ygaj+Oq+ntEZ/gGBbSyVfA2t
	 jSvYzM50YS8r5nPv+9JlCuUWPabzJofSZaO7LICsKi234yX3FHw2H6jSz0ltEYlTgl
	 5a1547R2f0AvmvQI33w+FtYaiSfOSv8xuC2ipFz34H5EH6UpLVfgf02mpNFU82NYaB
	 ha45Y+ijyl22w==
From: SeongJae Park <sj@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add mmap trace events to MEMORY MAPPING
Date: Sat, 12 Apr 2025 08:47:51 -0700
Message-Id: <20250412154751.60224-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <mcz3dhxkjpgp2qv72dx2lttwnzdvujvnosdx5a7lkjpuj3r4iu@jevlyctotoay>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 12 Apr 2025 09:17:21 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> * SeongJae Park <sj@kernel.org> [250411 13:47]:
[...]
> > > @@ -15571,6 +15571,7 @@ L:	linux-mm@kvack.org
> > >  S:	Maintained
> > >  W:	http://www.linux-mm.org
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > +F:	include/trace/events/mmap.h
> > 
> > Should mmap_lock.h also be added here?
> 
> Oh, well..
> 
> mmap_lock.h (include/trace/events/mmap_lock.h) has to do with
> mm/mmap_lock.c, which also isn't listed here.  Both exist for tracing as
> well.
> 
> There is also include/linux/mmap_lock.h, which is the locking itself.
> The mmap lock is used more broadly than just these files: mm/pagewalk.c
> and mm/ksm.c, for instance.
> 
> So I guess that's a more difficult decision.

Makes perfect sense.  Thank you for kindly clarifying this.


Thanks,
SJ

[...]
