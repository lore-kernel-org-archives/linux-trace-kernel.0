Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1A2E172B;
	Sat, 25 Oct 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761420992; cv=none; b=fpjVxWWf9bglJpRsdyCriKEg+qWrj0/MOHehrSllDfu8c09bhLtozev4H+lbUP1Lr5l+OTVNr96TmdSxTnMgaBnPnA+LO6IYGnb0P+Vge3h/XNinPLFVo0g4ANlBgK+0nYEalEvLuwYp5+2Mg9qlybKjFKqrKNBAFfu2reLxe+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761420992; c=relaxed/simple;
	bh=g2fBBldohsG59SjNVOq5oDldiJbgwEcd3P1N3Bfvg60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+G8I/fICPo1zNmYROB+RW5pMJlabfbPhP4j6u8w5aUPh/0lwmDu6kx1t4AN7zo32NAOO6WkyFpDvAEocI4fTHBggy3amrZ0aLDS/eeIgmnT6kvWz95mbfCfiUq4sx7WrzkiugyslgEskgfijq29PGn5o5SllwndzXbLcev51Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EDABD8466D;
	Sat, 25 Oct 2025 19:36:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id A710B20030;
	Sat, 25 Oct 2025 19:36:25 +0000 (UTC)
Date: Sat, 25 Oct 2025 15:36:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 13/21] trace: don't use GENMASK()
Message-ID: <20251025153624.4b049170@batman.local.home>
In-Reply-To: <20251025152954.25807ec7@batman.local.home>
References: <20251025162858.305236-1-yury.norov@gmail.com>
	<20251025163305.306787-6-yury.norov@gmail.com>
	<20251025152954.25807ec7@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A710B20030
X-Stat-Signature: sc4uzjb54t9mesd3dnyn9615188bnt6d
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IMKydI74GI/yMv7u5bcYC1/vHU0zkFk0=
X-HE-Tag: 1761420985-556311
X-HE-Meta: U2FsdGVkX19Vq3BJKjcVgHUuXYHdvXZBoFQhRmvRHh5ZPxSNYTTvFoFxb4vgukWEwFCVY3//nmQkWclDwtAJG/WUqoG4JEPSliE5QMtS4lAjbTAkEMxOjFSgYib1+qy0Fg9jSbACapUwIh/7KuSuJFzKXK7jjcWS7mIV7myuU8in9LM1d9Wk8CilhmYubovjWbqnL8S7vZLicum2+l9yBYgBHQZA0wiBMnSZ3j0uS9TNYviB2ktp1lBms2l357htl6lOOQyqpMhcHULROAsUchtyQCacHso1zjT4b1z7t4P7zvsdfPFuL/gWhIrZ01lxAwkDLdRna01NSCXiKZ4gqPRQTyIHouS5vhvuE1qSArmvsR8ubvcpnDUehiKR24AFnMoFW1I3HxCJyTVxMx+WGQ==

On Sat, 25 Oct 2025 15:29:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 25 Oct 2025 12:32:55 -0400
> "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> 
> > GENMASK(high, low) notation is confusing. FIRST_BITS() is more
> > appropriate.
> >   
> 
> I'm fine with this change as a clean up, but...
> 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >  kernel/trace/fgraph.c      | 10 +++++-----
> >  kernel/trace/trace_probe.h |  2 +-  
> 
> Make this two different patches. trace_probe and fgraph go through
> different topic branches.

OK, I see this is part of a patch series that adds FIRST_BITS().

Please add that first, and the rest of the patches can go though their
individual trees. Something like this change I would like to make sure
doesn't accidentally cause a regression. That means it must go through
my tests before it gets applied.

-- Steve
