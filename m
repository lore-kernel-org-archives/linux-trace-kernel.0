Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997861096F;
	Fri, 17 Jan 2025 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075440; cv=none; b=fjr0ugQFiM0Fexrfzo6V5QFDIYiX7FYNh4GG2vkfEYh+RlzuIbaciK1g9Kt2mF8XNHX/pR5qwdCOCfgnN15vyfDALwIxWXRhQdsx3RQTgRqGD56IU64UVFTm9xwS10ySIvl+8xFnktx5QaEZ5vh3mGwbsXNdvJAN4dr4cHvgbHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075440; c=relaxed/simple;
	bh=lb0dcD6WPgqef5oXxguwrA33Zjzc2JXokJhbASFdqCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M64/eDqwfFqAXhgBE5CGdn9PHxXRLACeRjtsHLxgAtYyQNJiPWbU1jqQVbB95duLkaMH6xpZPMe7JDmSVATRZc6wbs/6hvVPXkYXlZr8tZPaLSdfXxvRKZ+njXset6eexk9fEQFO3uSQUYIPBj2KP235awuopilmPV5RAAr+Wms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BA9C4CED6;
	Fri, 17 Jan 2025 00:57:19 +0000 (UTC)
Date: Thu, 16 Jan 2025 19:57:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Gabriele
 Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 5/5] rtla/timerlat_top: Abort event processing on second
 signal
Message-ID: <20250116195725.2afc9f88@gandalf.local.home>
In-Reply-To: <20250116144931.649593-6-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
	<20250116144931.649593-6-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 15:49:31 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Apply the changes from the previous patch also to timerlat-top.
> 

Same here. I replaced this with:

    rtla/timerlat_top: Abort event processing on second signal
    
    If either SIGINT is received twice, or after a SIGALRM (that is, after
    timerlat was supposed to stop), abort processing events currently left
    in the tracefs buffer and exit immediately.
    
    This allows the user to exit rtla without waiting for processing all
    events, should that take longer than wanted, at the cost of not
    processing all samples.

-- Steve
