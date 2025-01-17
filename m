Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF71FECA9;
	Fri, 17 Jan 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110996; cv=none; b=m5mCggSulYF9ep3f4G+qjx9IseVHAFoXWjxYfClZffanXc8xIRch3tn/pSIKLvocwKtUpqe6fDMfmYwMnVBy7Rx495mSm40bSlgzTQtty1BxbZ9k/9iGDwWEaddXYEtYWhN8scsqOOy05aS6GxumZ08FphqklyewO24K4SyNn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110996; c=relaxed/simple;
	bh=bJuf+j5eoE8f4PaKq0DLi49e4hW94wvOmMbAObkowc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tX9PUgDLrWllcTUe7rR2JIZzpi0VphMxIkBMqiE42IqEe8+WZ+ybU0fz9Rigio5C68mWu5V+CsfibKMkeCeCtMb4DaPsHJtus4WVZqJAt1fiPmff2RtMKC6N5mZQ1FqUNKzidG6YDqmd+UEcCmRioB8Kue3qHMwh/GoDIGfmTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D45C4CEDF;
	Fri, 17 Jan 2025 10:49:54 +0000 (UTC)
Date: Fri, 17 Jan 2025 05:50:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Gabriele
 Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 3/5] rtla/timerlat_top: Stop timerlat tracer on signal
Message-ID: <20250117055001.5c8de382@gandalf.local.home>
In-Reply-To: <CAP4=nvQUugz723Qav2xBD97ud6sM=ajEeNqyAVyqL1Qf09ZX=Q@mail.gmail.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
	<20250116144931.649593-4-tglozar@redhat.com>
	<20250116195600.60625aa1@gandalf.local.home>
	<CAP4=nvQUugz723Qav2xBD97ud6sM=ajEeNqyAVyqL1Qf09ZX=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 08:13:26 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> > A change log should never reference another patch. This is meaningless when
> > seen in a git log. All change logs must be complete stand alone.  
> 
> If you look up "previous patch" in the Linux commit log, you will find
> a considerable amount of patches which do this:
> 
> $ git log master | grep 'previous patch' | wc -l
> 3006

As Linus has scolded me before with "Just because someone else did it wrong
doesn't give you the excuse to do it wrong too" ;-)

-- Steve
