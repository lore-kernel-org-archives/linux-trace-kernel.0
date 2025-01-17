Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76656FC5;
	Fri, 17 Jan 2025 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075355; cv=none; b=aXX1XpzEIriSRPz1vMeJQ6SzcIX39VgmAmeT4OHD1YWWcWnEswqoeN+254Kos1H3izLFV623KeMp2EWp5FaQTNKRFR+bw5oYCm1sGE9OnhXVydWb2yUuQEEBwUbvYFUceLS2Uh9tG2zt8A3df2KMJg9w41dCnmf1x4LbQ1c/03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075355; c=relaxed/simple;
	bh=IYcQZnddO4JcLvzwmkxieRiZy1qMSI/Ch5HT0h8Byjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usA68RbSXkJkHwWuaq0bH9uGQUoirCGXfpPB9XvvY8wCSbF4xTXj798UGqxa0zEPhJyQPsjuQ66x3L8kda+NpqKszr8zoiYVVRSmARYzvODlpD5WU6cHRAts3EHiT7u1NAHP5BO6TSiDlmJR1vCBOkiRVdmGBJFXaJ/vBRcCV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E294C4CED6;
	Fri, 17 Jan 2025 00:55:54 +0000 (UTC)
Date: Thu, 16 Jan 2025 19:56:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Gabriele
 Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 3/5] rtla/timerlat_top: Stop timerlat tracer on signal
Message-ID: <20250116195600.60625aa1@gandalf.local.home>
In-Reply-To: <20250116144931.649593-4-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
	<20250116144931.649593-4-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 15:49:29 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Apply the changes from the previous patch also to timerlat-top.

A change log should never reference another patch. This is meaningless when
seen in a git log. All change logs must be complete stand alone.

I copied the previous patch change log here:

    rtla/timerlat_top: Stop timerlat tracer on signal
    
    Currently, when either SIGINT from the user or SIGALRM from the duration
    timer is caught by rtla-timerlat, stop_tracing is set to break out of
    the main loop. This is not sufficient for cases where the timerlat
    tracer is producing more data than rtla can consume, since in that case,
    rtla is looping indefinitely inside tracefs_iterate_raw_events, never
    reaches the check of stop_tracing and hangs.
    
    In addition to setting stop_tracing, also stop the timerlat tracer on
    received signal (SIGINT or SIGALRM). This will stop new samples so that
    the existing samples may be processed and tracefs_iterate_raw_events
    eventually exits.

-- Steve
