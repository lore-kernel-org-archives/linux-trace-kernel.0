Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F431B80B;
	Mon, 17 Nov 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368253; cv=none; b=aQTwmTbB8RU79qMkMWor4srdXNUQ3Y4XTMedCWTmCQq9YILM/pZa+zGV+mtOfdBrL9Jp/8T09QTwMuUqQ/8WavAtNwxxNvInH0T8EHBlHbrZ4/+nvrVcXqS/6KpyIfyEOZtt73cGnY0SXa+BUpltMoQgWsguugctroSaRLrTglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368253; c=relaxed/simple;
	bh=oyL4RAoPT5WjmfkBp++tzsd9cGfRBNBXVhXMABZr4Gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtT7FjLg+4YLdhwd7DRIz8NsUP29nSRMPc2bulATLetNQBRzoZ4fyG0wO5vIuPcIn2dRZjnHYFYgewragzZCE+8d6T4MFdtas9yYAQ9lyyJq8APdRMSqOYqv3cS8i1v6s0zmSRJDrO0iXQXosi2FhxyUFtx1J3gMpmPqx2yPeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bodu7qOZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2R0/8c2r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bodu7qOZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2R0/8c2r"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763368250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0Qd/B33hV7RKE+tJ507nEcVJgjRk1dxw3Zlm/uPsKo=;
	b=bodu7qOZVKpkp/HEsQIeWTOAQhsu4Ngwe2/STj0krjHw3OUu5iDQcvt0MKD9Qyvo7Ppk7y
	aXqmejtwOufRqkhq1s4GXV178gd9hLAVdhl2SKdx/2sEPNr9MrP7nO0rDoyDMHZBQv8t8j
	soldRxpJq/yerIrarGBw4LoIlwMiGoaIZMz4w/OhFeUszooJFxatLFHpurp8pfAnOR4XRT
	pnkStD/tHXaj9fFqkA67z+IafbMxlxM3YM0Hof27ts3xiRjJ5yzdGaLjcIGxKBCgJX0ROs
	78+WdJVYQTBdniC41TNQL2OZ9ZG9eEezXI0Sg9hsjQJyayWR/Ud+HI53BJuC1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763368250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0Qd/B33hV7RKE+tJ507nEcVJgjRk1dxw3Zlm/uPsKo=;
	b=2R0/8c2rvJaiqW4zpyQkHEUdmQF+GdPR1f7IyEzXrkkTO7QeNOAinrrhukU3mNFL6sqqA9
	MOHbb4a428RRl3Dg==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rv: Convert to use __free
In-Reply-To: <cb44571efe8157f126e519b7cf1932ad7feda7fb.camel@redhat.com>
References: <cover.1763306824.git.namcao@linutronix.de>
 <6b2a618815b45ac4ac09976ef4fb0bd3635c143d.1763306824.git.namcao@linutronix.de>
 <cb44571efe8157f126e519b7cf1932ad7feda7fb.camel@redhat.com>
Date: Mon, 17 Nov 2025 09:30:48 +0100
Message-ID: <87wm3pgix3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Sun, 2025-11-16 at 15:35 +0000, Nam Cao wrote:
>> -	reacting = rv_create_file("reacting_on", RV_MODE_WRITE, root_dir,
>> NULL, &reacting_on_fops);
>> -	if (!reacting)
>> -		goto rm_available;
>> +	struct dentry *reacting =
>> +		rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL,
>> &reacting_on_fops);
>
> Nothing is removing "reacting_on" in case of successive failure, is it?
> Am I missing anything or couldn't we just set both variables to __free() ?

We can. I overlooked this one :(

Nam
