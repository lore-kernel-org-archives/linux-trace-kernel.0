Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B515853B;
	Tue, 27 May 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748356739; cv=none; b=iReAdvfz3kYTfeM6vCbvZ7V/7EM7rMzGSaiIjWoBqtvF9FnTwsP2jOCpbh6v62uBkumyx9TpLzlw+lwcElF5sgvapY58s3/bm7kiiHt8W1x0l7h/4pUACgnYkSZ5jrAoSCKDW8sTX7vzObS581SxACGg27q0cjGMdV3/CLd5VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748356739; c=relaxed/simple;
	bh=kpLEPoNDPL7m2s/kN8JqafiEtTXYg8U4Fgolh5WnhdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwhtXHrtkkGKvaqWx4kAbZuyqI/wPGsBivecw0g0S1ZGgP0PL63xrJ5Aqd5fPD4eWMCOKB7q7Rj8N4eyO8LXaJZSdjO8lIMyHuXjFAqxfZUzmb7rHc/56/e31k8+PUh4mxI1qBhlFDgMqq8yWcLk0VzkFEY06tKknj8uhANAPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEA3C4CEE9;
	Tue, 27 May 2025 14:38:58 +0000 (UTC)
Date: Tue, 27 May 2025 10:39:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.ogness@linutronix.de
Subject: Re: [PATCH v9 12/22] verification/rvgen: Restructure the classes to
 prepare for LTL inclusion
Message-ID: <20250527103955.72002d62@gandalf.local.home>
In-Reply-To: <91719ddbeca0e37617558687feb1191a69793dad.camel@redhat.com>
References: <cover.1747649899.git.namcao@linutronix.de>
	<c1dd325f5f8f01dd7c29ff90be22164c17f073a0.1747649899.git.namcao@linutronix.de>
	<1927d98817cd97a70d177e0a3001603ee3e34b35.camel@redhat.com>
	<20250527092734.BgoHvn6n@linutronix.de>
	<91719ddbeca0e37617558687feb1191a69793dad.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 11:32:35 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Sorry for being pushy but I'm have a couple of other series kinda based
> on this one and I'm getting a bit crazy maintaining all that ;)

Welcome to my world ;-)

-- Steve
