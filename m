Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90892146D6B;
	Wed, 15 Jan 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954810; cv=none; b=Ty8MAQ7fh5/tPVvPxZ7QLNJ5F+pW1VBh1Ja6vKhV2KJk0cJoup5HV5VKFO8DBazys3P1Fa8jLazNaQ6xDMl8oarhXzb60B2qzMcx/wKwHj3/FqVx1xjvgEypIDddr+uUxoLz8BBSRYoRRFRk04sm2IRalscHw1h4VyC6hz6b8uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954810; c=relaxed/simple;
	bh=WwSLIpyBGidJ68Rdn/b7fcukP28fqz6kKV4TBaVASOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy+ZmVDYv6f4xY3PFmRIvRwCWxgGzLRWL5R1LURJ6hezx4lfCIHDoh8FV23sAsQhxTUuU7zj2q0PB/tLMbuCMs04VZoTs9E//AzSlhlPfkzZ6FdZhgXL7lrHRzC7kGzfprIEUxB+VNyjhtf//7uKnYlndFgRdGADxkgRmfgEBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E841DC4CED1;
	Wed, 15 Jan 2025 15:26:48 +0000 (UTC)
Date: Wed, 15 Jan 2025 10:26:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, John Kacur <jkacur@redhat.com>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix bug and add osnoise_trace_is_off()
Message-ID: <20250115102651.306f3b7b@gandalf.local.home>
In-Reply-To: <4ee1e1a7-f0b3-4062-97d9-45a342d0ca21@stanley.mountain>
References: <20250115081157.1274398-1-costa.shul@redhat.com>
	<4ee1e1a7-f0b3-4062-97d9-45a342d0ca21@stanley.mountain>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 12:02:00 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> You introduced a bug by changing the order.
> 
> You have to undestand that to the original authors this stuff was really
> easy and they knew the order of the struct members because they chose it
> deliberately.  In the end, they get so used to the code that
> "&record->trace" just becomes an idiom for casting "record" and they
> forget how it looks to a newcomer.
> 
> I *personally* am not a fan of code which assumes we know the order of
> the struct members so I don't have a problem with you re-writing the
> code.  But the commit message must say that it is just a cleanup and not
> a fix.
> 
> Which reminds me that I had intended to create a container_of_first()
> for code like this which assumes that container_of() is just a cast.
> There is lots of code like this:
> 
> 	struct something *member = container_of(p, struct foo, first_member);
> 
> 	if (IS_ERR(member)) {
> 
> Which relies on the face that "first_member" is the first member of
> foo struct.  It's a quite common thing.

I agree that this is not a bug, but I will happily take a clean up to make
it more robust.

-- Steve
