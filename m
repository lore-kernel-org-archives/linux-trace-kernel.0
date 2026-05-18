Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2593D6CA7;
	Mon, 18 May 2026 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092120; cv=none; b=DFSyKpzki1ndx+ZMpp6SzkL96ztOQ/PpxCNGoLFDknohdTOalq1n4H6OZyHvg+ri2rtoOXUaSgUSM76LASVVL91k4p89LaaFtXq30HBgZmRzZF+t9RYaJGi2DGU2UC+hIUdVIy+vyyMRsJoHHgIGFYOEqGX4qa2cJwPTdgdIyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092120; c=relaxed/simple;
	bh=Nskmr4uqy5nj7xlnRs7WQQ+yaWWeXlND9Bxqtq0tn68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uD4+iZslMhYooUevX4CiiV1VEx5pybCUzuP7BaGg6/7+A5THDadzc1YnV7H9kD3ml0L1ms5a29i07Q4vUmXriJrt5gak3ufW+pzB6IYqGaAlFZBxD8DFgrTVvIqf/W2uuEhIgnpqn+ZYFLhbynBnwHKJHObCjHkNAeWWXy+6Cdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0LpgiHSY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Q3LQOw7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0LpgiHSY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Q3LQOw7"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779092117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLqj9XRrr0Z3v2YNyYxWFpiYGDA97tGjtbimOy6Nc1M=;
	b=0LpgiHSYELrIbj1umeanuvAtBRRiRGLs1FeHuy0PjDuNO9zxnZ0vPHPay70qI+BnlYpgxU
	ne+PRcvcBJnn00E018fPJ89d8o/58o6EJTGE3+M7ID8E5qgn3WEOmEi1YaVNaQr5o5WVyz
	+j3FiwgG3rfVXPOjAmn32/pll4uZbqujtY6BgVxo1d+QBuSwSL3J5JZc9gjD2ReGL8C076
	FcWbMsjzSC3dmKwlsrit/2tS0uA9AEolmlqMimBMJuhc9lMmMAtUjWQrZ6+HkWSZ6aeQ4C
	VfZhuWGMqvfU3cjkKgCAcYkm0MGyQJlIeqMUjpx2+UVQufKio942mYa9GEx3NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779092117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLqj9XRrr0Z3v2YNyYxWFpiYGDA97tGjtbimOy6Nc1M=;
	b=6Q3LQOw7QthxGbht9QMmQlM4U6iUH25YEogpITmf4c3519C6xYmVvAg68z6lkQssWz9B28
	7PW9SAVXT+psjbAA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 01/14] tools/rv: Fix substring match bug in monitor
 name search
In-Reply-To: <87ecj9879f.fsf@yellow.woof>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-2-gmonaco@redhat.com> <87ecj9879f.fsf@yellow.woof>
Date: Mon, 18 May 2026 10:15:16 +0200
Message-ID: <87a4tx876z.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:

> Gabriele Monaco <gmonaco@redhat.com> writes:
>>  static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
>>  {
>> -	char *available_monitors, container[MAX_DA_NAME_LEN+1], *cursor, *end;
>> -	int retval = 1;
>> +	char *available_monitors, *cursor, *line;
>> +	int len = strlen(monitor_name);
>> +	int found = 0;
>>  
>>  	available_monitors = tracefs_instance_file_read(NULL, "rv/available_monitors", NULL);
>>  	if (!available_monitors)
>>  		return -1;
>>  
>> -	cursor = strstr(available_monitors, monitor_name);
>> -	if (!cursor) {
>> -		retval = 0;
>> -		goto out_free;
>> -	}
>> +	config_is_container = 0;
>
> Isn't config_is_container unused?
>
> Perhaps it is used in a follow-up patch? Let me keep reading..

Never mind, I'm stupid.

Reviewed-by: Nam Cao <namcao@linutronix.de>
