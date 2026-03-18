Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807601DE3B5;
	Wed, 18 Mar 2026 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773803245; cv=none; b=N5NK4wtjzdTJmHRPsYDfOspitKMh6kp75hIvT55AWLyG+8MiowVTqOuM6z9tBuR7noxwQrZQZRaR2QJwmw3Ihwi+ajb8f4O6PYYmZXmvdcdbBwKtWvRfHhBmqSCgOer+s7iRfNZcN6YNumh22U1ezjfft0IHvxZlwx9YhGpk4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773803245; c=relaxed/simple;
	bh=k0T54XKl06Gz1qd5NuXbPLesJa1D++sgT1RLra6h/zc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VCzpBEomQmeGiF0GfmuEz6dC0f6n39m8+IKvrDGx8TbYJIJgD6tPrMdXjjkiQ2cI/dDWBb+d3aslwMPqZd4leT0hcjNTzbS5YupwlUW4tW3BrxqbW8HvH0tpO/v5TPVbDzt4WbUAghsQrUw2copTkGfwqVj/Gp/Q5l0C43ZXOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7vJTfj1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7vJTfj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C02C4CEF7;
	Wed, 18 Mar 2026 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773803245;
	bh=k0T54XKl06Gz1qd5NuXbPLesJa1D++sgT1RLra6h/zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7vJTfj1DZatzMFqoFxlturotgOB68ow/raSLNbUNSM11DqO2JXf24SHquoBDZoOQ
	 7zEY9bj5pIpK+ReY6FuzysVXGcb+FWrfuk8qGqM9CCLyxeUfbgeACER8uVcrjRV7Z+
	 ACM6LH1FCuvXXevdUj7fC9EXbXlLlK9iBqUk3zv9JDc1aHD6qIzTyu+0gdodkG+LGq
	 cBFfigxu8vfX51KgZ9/AlchamgPC+okCvxw3eAk55B8MNbMP6FCnF0a9GmaTyns/CB
	 7BPsFeQq8Q/zoF1NJjUfLQ3wCph93jX5dnKvG+KNVMQfmW4oQ5a0Hoq3B4Fktc+z9b
	 Quwjn1/wfESTw==
Date: Wed, 18 Mar 2026 12:07:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Law <objecting@objecting.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-Id: <20260318120722.322e08498074da62a9d04503@kernel.org>
In-Reply-To: <20260317204327.3c61d0ea@robin>
References: <20260317204403.72375-1-objecting@objecting.org>
	<20260318080351.dae637f4b5909bd9f81b27d2@kernel.org>
	<20260317191626.5b6172a9@robin>
	<20260318090243.7c437f2c5e07a1ce00375102@kernel.org>
	<20260317204327.3c61d0ea@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 20:43:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 18 Mar 2026 09:02:43 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Yes, that is checked in vsnprintf(), not its caller.
> > I think linux kernel should ensure the the return value is smaller
> > than INT_MAX, and return -EOVERFLOW if not.
> 
> Well, there's very few places that could have a buffer size of > 2G.
> 
> What's the max bootconfig limit? Could you create a bootconfig that is
> greater than 2G?

It's just 32KB. So we don't need it.
Anyway, I sent a patch about that. 

https://lore.kernel.org/all/177379678638.535490.18200744206158553364.stgit@devnote2/

Thank you,

> 
> If not, then yeah, we shouldn't really care about overflows (and that
> includes not worrying about typecasting the size variable to int).
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
