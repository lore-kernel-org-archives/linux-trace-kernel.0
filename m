Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89801BF50;
	Tue, 21 May 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307780; cv=none; b=s2WGReIzkARsYrbd9VP85Mbo/ijfZEIW1QIx4KqblJ3cJyFZYuUjbfaFuV2XaqHj5AMJJ5Oja2vD8VXcz3oCXDJJFSQzjhltya0pqxzRQRxQ4SNMQTw53z7LFRp7RwTsr5NpBD6OPsC5PXJXh9JvVk99n6mZslBYBv+LSpV/kvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307780; c=relaxed/simple;
	bh=LWMVpIWkXfLQ25ul/kZ8y5cqMt+I/QDuWD3dNc+puxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3qmFSWdKLllu4vD4TwASjZKvST+PNH4rLvIY8Kl9zid7/EJlJbX368vLoi2cEm3ay0wF93TsDOXnOIw2MKGEZhdb1rk8mpPD50N1UNQuApznu+VlQQ19TJlzn9kWcThcWk3JW0PVuA0OwlB75xS0W5bOWHrAm1hRNX41NVAlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A67C2BD11;
	Tue, 21 May 2024 16:09:39 +0000 (UTC)
Date: Tue, 21 May 2024 12:10:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/latency-collector: fix -Wformat-security compile
 warns
Message-ID: <20240521121019.5124718a@gandalf.local.home>
In-Reply-To: <466e5359-067c-4ab5-9476-06daa44dc83d@linuxfoundation.org>
References: <20240404011009.32945-1-skhan@linuxfoundation.org>
	<466e5359-067c-4ab5-9476-06daa44dc83d@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 09:11:08 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Any thoughts on this patch?

Sorry, this one fell through the cracks. Daniel Bristot has been
maintaining his tools and I thought this was one of his changes.

I'll take a look at it.

-- Steve
