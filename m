Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364F1B3921;
	Mon, 18 Nov 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948171; cv=none; b=mW+v3ZbR3cilPehkj85t/qEtwOWuA8LAr5ZtGJVbooiSfMc8R6NH2iiYko7rZ5OZp1HO89yf2elieGkhh8gG7JRrhUtnLLcwva/InDjuJ2Zwq+ZJwbFvs3xHTYgTiefIJnPImKBNR320do31ysiqpf6URMMRIbbJxcmI6Bz4cgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948171; c=relaxed/simple;
	bh=wu03UBHx3W0uDaGv5wdgvG9LKRhh2UlqSuVq9FuDcEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMDkPGe6MWVq08SRe4ibP1VHcAvLj0TW5+gmge/nQ7NNToz61oPz8pe3W4uUqAc7bdFI6ZxANsGFcyWyLoRxoZ8VVjX4f5tnvOnI0xL7AIZZc8zI10Q7dS4DDAo2j4qwS1Rx34VAeynEtxeS5YNqJy/uPWL+6MNEECoaOx3bPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4173C4CECC;
	Mon, 18 Nov 2024 16:42:49 +0000 (UTC)
Date: Mon, 18 Nov 2024 11:43:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: jeff.xie@linux.dev
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
Subject: Re: [PATCH v5] ftrace: Get the true parent ip for function tracer
Message-ID: <20241118114320.3ce1b022@gandalf.local.home>
In-Reply-To: <991260353fbe141ffef8db7a08ed8fb2473e4ca0@linux.dev>
References: <20241008033159.22459-1-jeff.xie@linux.dev>
	<991260353fbe141ffef8db7a08ed8fb2473e4ca0@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 16:15:02 +0000
jeff.xie@linux.dev wrote:

> October 8, 2024 at 11:31 AM, "Jeff Xie" <jeff.xie@linux.dev> wrote:
> 
> I'd like to know if this patch can be merged into 6.13?

Bah' I missed seeing this update and it was buried in patchwork on the 3rd page :-p

I wish you pinged me last week.

I just sent my pull request for the ftrace topic branch, but since the
merge window just opened, I can start testing this now and then push it to
next. Wait a few days and then send another pull request to Linus by the
end of the week, if nothing breaks.

-- Steve
