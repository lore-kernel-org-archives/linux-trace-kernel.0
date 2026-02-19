Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899B2701C4;
	Thu, 19 Feb 2026 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524141; cv=none; b=H1TPcUMHWBM5NMAjyXsw/vHL6MQUdVkVtlgbuAL/GFJHA9OsfhFKlFrpq8YRdEttSIS8E8uFjsRrtYjl0++0USakFXAxCXQ2I0JWgTchAzKscUVYaLLHiDWW0sY12+a1yGlCZaXhLBhUx6DSODXkRfoCnO7t+j4O0GF4u9qop/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524141; c=relaxed/simple;
	bh=gel+BEMtKX2XSW8VWB4DH3PbNp7s2CW7KMas/ZPQvOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUAwmy6Q9o/T4K37GIEl2vIg9AstQBTVprNP1SvKmdc4NLDwPd+2uNwPpnFO/leVI0SPyIl8QRyiMNCG1taS+6MUOfbmV+5hhvKtnygqyl/3WhZ3bVd22m2Od8VVpxlXuYJG8J50MQzTtHB9W2BrrCh8YXz+0lUehlBGYQkU/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B2B8A1A05C3;
	Thu, 19 Feb 2026 18:02:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 56CE52000E;
	Thu, 19 Feb 2026 18:02:14 +0000 (UTC)
Date: Thu, 19 Feb 2026 13:02:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/30] Tracefs support for pKVM
Message-ID: <20260219130220.063c8db3@gandalf.local.home>
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3in7iq53re3wcp4bjfb45ehj6p83i6w8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 56CE52000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX189EHO2cj0/ER1Y3s2xm8l7FxzngbV/18k=
X-HE-Tag: 1771524134-16267
X-HE-Meta: U2FsdGVkX18KsOW634c556Ay13vHARR3KG4iY9bpKgjeimF0kt32KKjae7aXrRnSMJvjA24rkCK1I2KRg6sbjxJ4TuWrR61mVJD2cJ0Md77TIqpMR46+fiK1TW7LwmkXwHbJgeYwTaQLsvKdGP64eU9XY5K6aTGQuiytjdf7LgNTVVhPHrEszyGEi+0EsoLYqoydPvHsWxetb78EJZV+8+Fb8NZAqef5y3BfvnJW4bxA/sBaUm5auwcuTGYwiowNUjGGHA40xyhyOyNL8X/ne61begI9OBko2AupzQZjhIq7xw99cqZ4nRkajdMKJWGMsz7fTOODChuVshdY889FxsOPUcjSK03I

On Thu, 19 Feb 2026 15:02:37 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> The growing set of features supported by the hypervisor in protected
> mode necessitates debugging and profiling tools. Tracefs is the
> ideal candidate for this task:
> 
>   * It is simple to use and to script.
> 
>   * It is supported by various tools, from the trace-cmd CLI to the
>     Android web-based perfetto.
> 
>   * The ring-buffer, where are stored trace events consists of linked
>     pages, making it an ideal structure for sharing between kernel and
>     hypervisor.
> 
> This series first introduces a new generic way of creating remote events and
> remote buffers. Then it adds support to the pKVM hypervisor.
> 

So I finished my review of all the tracing patches, but I just realized
that there's likely going to be some major conflicts with changes in the
tracing tree that's going to happen against this series.

To solve that, after -rc2 comes out, I'll apply the tracing portion of this
series to a branch in my tree directly on top of -rc2 and I will then use
that to base my changes for the next merge window.

Then the arm/kvm folks could start with that branch and add the arm/KVM
portion of this series on top of it. This will prevent major merge
conflicts in linux-next.

Does that sound OK?

-- Steve
