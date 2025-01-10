Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94E1E32C5;
	Fri, 10 Jan 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514265; cv=none; b=OmeW+PYGarik/kC7Tyeli3cBXrbmyk75MV48ZR0G33P4RTy/V6cc5inDtwZFuRV/VavB4RZFpLoYatLaTTWqhMwCLSLyqN3oTd/P/BeMaFX9uVu9sQDHnVNs/zateuLpN9wyJaJm7ftl1radQqpdRoCZT4PPwot9jpNjS49cjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514265; c=relaxed/simple;
	bh=xMmP08q2wdyVMIcDAtN90o/e0/haVfF34nF5KwvNEEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGubs15ii9lcu3zlwnWqPWQIgQmsuvTnzaEg6Bv2Hz71DIj3WGnYDXv8ZrYnAKR9TUVr+GAik4kg9hcu048NhZphtMSLXoq9FuVmbFrFGce9P+tYbin8YtRShCN+J+e14cHZHT0Sy7q0u1FK+5J0FricugJPxSDBUB0V9nC0/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D2EC4CED6;
	Fri, 10 Jan 2025 13:04:23 +0000 (UTC)
Date: Fri, 10 Jan 2025 08:05:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, John Kacur <jkacur@redhat.com>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtla: Fix implicit NULL dereference
Message-ID: <20250110080559.09f781bc@gandalf.local.home>
In-Reply-To: <16990bcc-c328-457b-a789-0f318d8eaf3f@stanley.mountain>
References: <20250109211358.2619367-1-costa.shul@redhat.com>
	<16990bcc-c328-457b-a789-0f318d8eaf3f@stanley.mountain>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 08:38:35 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Tracing code is generally fast path code so maybe we don't want to add
> a NULL check?  If we were really bothered by the existing code then a
> better fix would be to add an inline function to do it.

Note, this code is to the user space tooling (see the "tools/" directory)
and in the slow path of that.

-- Steve
