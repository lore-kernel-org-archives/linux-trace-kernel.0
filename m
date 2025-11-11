Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126826B760;
	Tue, 11 Nov 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905044; cv=none; b=HkBmmuE6/Hxmu6POq+VJvjSDC8ntP7oHW/JzKu8heNMayZ7nO+IIXz14A6IiuM+JdIZ902l7n23YGTpEDcgne2qDUOAen1oxK22QUflzkd8M/ayeqABpfkNt3Mmq8VBQelypcDB0lmiAhs7BvndFsN1Oyh3AErekT0r+cW6rcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905044; c=relaxed/simple;
	bh=zYEFGSpbh5QVtMNWkfebiNl3sYg5AT/6cdw0nIpNhjA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TSZ0018jqhOW4G+yYQCq33Br9+2QKcbnGPWVqL0ZQEv4tJYb/DcvGweWw/YZVKVBy3B61ddLwIaOXRZDBl13TFBscUgEDrocTb529yd6XT2DZOtAUzcewOVUYL1tQ9yBIKABjNFLyM/O4SO8me5CDZ+icXawojTHUYZaO0Kp79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sbq0zAF8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sbq0zAF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799FBC19422;
	Tue, 11 Nov 2025 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762905043;
	bh=zYEFGSpbh5QVtMNWkfebiNl3sYg5AT/6cdw0nIpNhjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sbq0zAF8ZoyJ4/uRqYKb/iFdUnRXolH8+oI/TIRRzMqSZSt9zA5kQE0jsUEmJTEXj
	 mk8R3WEuV/HVLTPG6Pt+mb/jCfI5SJGy3dwwWR0pIiai1Hcby8nZsidkp0W6bhkLLR
	 /wjfCZT4mAuO4NKy/bmvJGeNQqJUqTCWAa2ZsDpc=
Date: Tue, 11 Nov 2025 15:50:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, David Hildenbrand <david@redhat.com>, Zi
 Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm/migrate_device: Add tracepoints for debugging
Message-Id: <20251111155042.b07ecb045c978fe4c457b1d0@linux-foundation.org>
In-Reply-To: <20251110161954.47d88433@gandalf.local.home>
References: <20251016054619.3174997-1-balbirs@nvidia.com>
	<20251110161954.47d88433@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 16:19:54 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Oct 2025 16:46:19 +1100
> Balbir Singh <balbirs@nvidia.com> wrote:
> 
> > Add tracepoints for debugging device migration flow in migrate_device.c.
> > This is helpful in debugging how long migration took (time can be
> > tracked backwards from migrate_device_finalize to migrate_vma_setup).
> > 
> > A combination of these events along with existing thp:*, exceptions:*
> > and migrate:* is very useful for debugging issues related to
> > migration.
> > 
>
> ...
>
> >        hmm-tests-855   [002]    50.042800: set_migration_pmd:    addr=7f2908a00000, pmd=dfffffffd39ffe00
> >        hmm-tests-855   [002]    50.062345: remove_migration_pmd: addr=7f2908a00000, pmd=efffffe00403fe00
> 
> Each TRACE_EVENT() is equivalent to:
> 
> DECLARE_EVENT_CLASS(event, ...)
> DEFINE_EVENT(event, event, ...)
> 
> Where a class is around 4-5K in size, and the DEFINE_EVENT is between
> 500 and 1k in size.
> 
> By using a single DECLARE_EVENT_CLASS() for multiple events, you can save
> several thousands of bytes of memory.

Thanks for the detailed review.  I'll drop this version of the patch.
