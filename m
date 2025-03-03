Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72A1DDA3C;
	Mon,  3 Mar 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040616; cv=none; b=d6ansjeH2ieXCVXA4VimonDSRu20I2+VoIyG8qo/Dy7DoRrBp67Trzd93kDPIh/78SgKKeXeq4nMt0vs23h9rsOHU/FSZWemsFLK0LSCrHlz9GZpkTbIwGDXFsRuAk6xCosRHQg3xz458xB9fVad4hZBuVLd+y2PBA3YZaeCB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040616; c=relaxed/simple;
	bh=uHU0msuo6LE/sTtKRcI7R/wNd3MTe9c6mL/acWjYvOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjzGJITASt/efj1peXJIcGTG4p3znCpdL6OOy94mAJW5vIoIOxuBKtaxQ074OY+Dfq7rmFt9FtPx7a++X4P8kePjt6qty/BA/H9DIwk8d+WvK9Swbo4+iXnt8FJ46WwE67yYCyGjO8MflY+LMqz5IgvmgMKbJqQZhoiQSsni6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5DFC4CED6;
	Mon,  3 Mar 2025 22:23:34 +0000 (UTC)
Date: Mon, 3 Mar 2025 17:24:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/ftrace: fix boot time slowdown
Message-ID: <20250303172427.1ae6c924@gandalf.local.home>
In-Reply-To: <20241210230056.185826cd@batman.local.home>
References: <20241124140705.2883-1-rppt@kernel.org>
	<Z07KnNk5AK_Jq6CU@kernel.org>
	<20241210230056.185826cd@batman.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 23:00:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 3 Dec 2024 11:08:44 +0200
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Gentle ping  
> 
> I'll take this if nobody else will.

I guess I'll take this for the next merge window.

-- Steve
