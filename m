Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5673CC7DC;
	Thu, 21 May 2026 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365662; cv=none; b=O3HbtFLrPHj5Dvlf9/v1XWyCanl5g8nlG+upDzsVkAgV9Zicuylpyp7qeCawR2p7nPM7tle2MjizYt0JzO+KzKAoJFxxM9fKW1y2cONSZFlPBWV8plt9XhCgTJk2Xbio6heEUQe/3x7buXWdkQlokX+DYoMxGCWF2c/0lMT6yGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365662; c=relaxed/simple;
	bh=N2z7IKKgw7GzJdB8nRB7tR71HFjPAb2HMsOZdyoRq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc0Jnx8EpYBSeq1wIFrOfs+fBAvQHmfY5axseSBipoaUeJyJzS3Af2hjgfMFCkZdTX6mo//2VjP15bVBiACecVlzM/oL8w5UkbWDQNE78ryhp8N43QcCwRfZfDDY2D0ZiG8Y1TBxyHKp/Gw872ESFe1+iAeAguoAWezNUoSqBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3sn76S7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3sn76S7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB331F000E9;
	Thu, 21 May 2026 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779365660;
	bh=t0NdNyTYKm7zKLWDyPMJpNIzT3eS01I9vJKZhsRRZz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J3sn76S767n+1lCAz8F9aKMJIDg6LGdCCdqOaWV6Dh3RhNbvGPR1PPTpl39AhoTW9
	 ozYSz4ktpAZC07j8EQ7NUZ9ckFz4wIT5zUgjO3//zGwwnCVQdy4WEVeb5R92KmEIAI
	 YnFpy7BsfzilVw+RwURZ49SiArg7zMvNmmhKuFbhXf6RUBBX7V4sdrCieGoOqxNtfa
	 L0y6OWkuFxDOxV0NqEZxXqDI0XjUVOOtmz6cKiNxSr6483htBxInZm3+9yzr6FicIT
	 HzrU+EDaSIYBE45bdwyZhRcO7Zwbgy0uu/tt3ylV3GXnhP/QN0+nAC9cWPjZ/jxnla
	 F9v+xXUYjOQRQ==
Date: Thu, 21 May 2026 08:14:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 09/10] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-ID: <20260521081434.1b5eb123@gandalf.local.home>
In-Reply-To: <20260521153416.71be1cd6a42be89a12e0bc62@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185018.332045380@kernel.org>
	<20260521153416.71be1cd6a42be89a12e0bc62@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 15:34:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> I think it is good to show the dropped events. BTW, is it better to
> comment out the line, just for parser?
> For example, add a '#' at the like.
> 
> # CPU:5 [LOST EVENTS]
> 
> Ah, but it is already done...

Yeah, can't modify that. The "[LOST EVENTS]" output has been around since
2020 and changing that now will likely break user API.

-- Steve
