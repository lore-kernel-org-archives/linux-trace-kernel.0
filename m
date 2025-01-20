Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FF23A9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jan 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412674; cv=none; b=ni8wzxA60boYFexzmFUjxGOirBVIG17BiTDL65yTZ/fttxYoeIFz0H9qi6QYoe8pvbQs+BEjas/sAG/cqaqJF4k9a+SfHTkr/FMzVySYLPtrbteqnx2bZOlkgBWLYj3KazCXvs4JoLVoiD5EsSp26Nfy4EDX1b0LmpcF8XgDoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412674; c=relaxed/simple;
	bh=BfgRrIwkPwa3cpwG7v9TSZ3yK00HIdZTyTgwEW6JD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGQKndcMYweBalLsE2WiDbzRoODWIEO725JSAms/CbYxN6OE9XS/8SbUsrFP5NpoPFT2zDB4i+PlTr6jcbu9wSoHN/uuMr3uWCzikejb8/H0QbqmmLSOmu7hlQ9KzfTFfsE3+W6TWfyDQ6yyq9zTHoH5gsR13v5P9hcDP6NKGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC76BC4CEDD;
	Mon, 20 Jan 2025 22:37:52 +0000 (UTC)
Date: Mon, 20 Jan 2025 17:37:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
Subject: Re: [BUG] spinlock recursion when enabling function tracer on
 32-bit
Message-ID: <20250120173751.7ec67e17@batman.local.home>
In-Reply-To: <150fa7ce-eec6-4452-8552-da70cba84a04@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
	<20241218110115.29d4cc77@gandalf.local.home>
	<bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
	<20241218163526.2569917f@gandalf.local.home>
	<2d634c54-d8d9-4f33-bfda-9236b6a2ea06@gaisler.com>
	<20241220100558.10b48f0f@gandalf.local.home>
	<150fa7ce-eec6-4452-8552-da70cba84a04@gaisler.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 15:41:47 +0100
Ludwig Rydberg <ludwig.rydberg@gaisler.com> wrote:

> I just wanted to check if you saw my last reply to this thread.
> I've tested both patches, and they work (tested on sparc32 and riscv32).
> 
> Let me know if you need more input.

No I missed your reply. I'll add the ring buffer code now, but the
generic code may need to go through another tree. I'll post both
patches and see what Linus thinks.

Thanks,

-- Steve
