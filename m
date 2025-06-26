Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61D2E7645
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945726; cv=none; b=NogpvJocTekBaQ3jaiFp6M5TrkGbLTTmqtkyCgvNIT5yFGIn1PeMsS4jBuWlRjwNJYTm5cycjE0+0EPZ6PyjGv5tYmpSoicvl7d30WY9ucs5DwJ4ykvL/xn4buc8LOGjCUrQGSqGhZdc4elQ+CEttE+jgiAOC7DxT3iDuuvyYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945726; c=relaxed/simple;
	bh=jAU0aOHceKYNcCYExz5XRGz1x3hYT4dCXMxeIfFPfBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/d+Lc8eBFY68pAbsn4/q4N5y4T0Hff7O27VmxHBLggyfuAkMd+pkuVMqD+GC4dv2igxRn0l5VJZjqFQM5Yc3doroXNNBvhFBHj+u9I1QEiG8d1wmmRlZjN5hE8jul85E7kt73LsjdbmSMIqKuMq7jU0vdFuqN25iG1EC9FQ2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=I93Fnaph; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="I93Fnaph"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23649faf69fso10479145ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Jun 2025 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750945724; x=1751550524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJtqONCBTd1Gv0wLO+PNarwx+koXGlu1bl6aoxfQ5Ag=;
        b=I93Fnaphw9eN9hWdDLAP264CaWU4stPzjHjAyuKrx1Nnhq6SKOhUo4zsha1HYwh6Fz
         0TbpR1+U/czOEEE5mAqRlVvSHHrraZsmUd9s5uQc3p6qQ+GrKWCzwmXVF8rt5702OikQ
         QmVjjCaKsul0vRW18kpG78IWu6BaTEMHuF5n+VFiDk8zfFllqHe38RunWWg3uPJOALw7
         hT8eOgkjiynEuRkButeNW9arXdg7V6tSkcnjoWnJ7f4INDy2QaKSuDeXfP3ifLcZqnYI
         3OI4nVZEhO00TZ4l3QTZoPB9seWXvzZjH7Sytx4xTF00fF9gFb5Xs2je40FyeHss83Y4
         lU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750945724; x=1751550524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJtqONCBTd1Gv0wLO+PNarwx+koXGlu1bl6aoxfQ5Ag=;
        b=VkGMMj3iIO5LoRViHacIN0c/HOswlVzKVsP9I7DNeFG0zyxoyo+h26M3iuf2GD8/7j
         v7KWCMBsW70AfeatNBVDUCFSpaJM1espYW6/QdruXcfmCB6ZGyeKisPf4cx+uA5z1aIt
         T4ij1rk0NDzZc/1GiIcHSZu7ElwnSMy5meRJo0dRYiVg0wgA5yDzTe34sTL4095+ZBUt
         EuNr1qhS1JDb9FWX1sFv6m8JOChULMxjeTS0rqtvYKYBrA15MmssJKuNfullYSMfdNCI
         I9dov6WJKxvHtlStTiWkBhjgjGPPVL+0DkfOldOieWrwNuaTIIowaj/jDoKXUdxX9AZp
         Ko7w==
X-Forwarded-Encrypted: i=1; AJvYcCV5B/RifuirQmYS+Q7UzhyGp/uXLVC8Zi0S1EfXkAZy4WtpvcSZPmphyRc6ADkrox2qhDMQzdoSaD/eEAlW+ommJ+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQ5n8ytM3a5S/vAuzZo5oGxpEwM+Lq4P5HZhpUqE9ARRdhEIP
	YVGVkjBji1SsG8lDZynT6CqWVje4UrERVVMAp5EdR02WJ9LM1pqfRjAUZPAaKixOngg=
X-Gm-Gg: ASbGncvl9vgth2Adx30vUU+HCH/oV3T+Ssga1V3foB1vt7Oic3bnqhtgnkymbjK6k9/
	9HdhXFHujb0KWb1raZ0M52NS2+r+0gWxXB6ZZE59v5o5+hz/lHW1j1i373wAHIzhJUqAI3ouv33
	VSIUVxwjqaQpBcOrLeIuq8TXqhj/mgCWvRlD28Muc0+WPBaby72qcnFviBPgRiVTz5HQH+y5UPX
	B8YH3b0JDNsH03U74P1NmD85oMPzIAAfHgVNI9Dj+7SEtjUQcE0sqYrfs/jALcC111zoJ1cCza+
	V+bMFEwOx2jF8zLl60nGC37lEfuptZZlNphk1EI0S+DCBege4etIQoOWfK18SQBLF7zN
X-Google-Smtp-Source: AGHT+IHaZxlWF+YhElFCAwxYF4cK8J7XWLEsDwhwcGid+kpLovDJu4Tpxovjl6eB2F21LeYzhc7jVw==
X-Received: by 2002:a17:903:1a8d:b0:235:f70:fd37 with SMTP id d9443c01a7336-23823fdfe7cmr116316585ad.19.1750945723795;
        Thu, 26 Jun 2025 06:48:43 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237eec29a77sm117429145ad.165.2025.06.26.06.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:48:43 -0700 (PDT)
Message-ID: <a3b456f2-deeb-45c9-b509-23bbe5e96cfd@kernel.dk>
Date: Thu, 26 Jun 2025 07:48:40 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/11] perf: Use current->flags & PF_KTHREAD instead
 of current->mm == NULL
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250625231541.584226205@goodmis.org>
 <20250625231622.172100822@goodmis.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250625231622.172100822@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 5:15 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> To determine if a task is a kernel thread or not, it is more reliable to
> use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
> That is because some kernel tasks (io_uring helpers) may have a mm field.

This commit message is very odd, imho, and wrong. To check if it's a
kernel thread yes you should use PF_KTHREAD, but that has nothing to do
with PF_USER_WORKER. In fact, as mentioned in a previous reply,
current->mm may be non-NULL for a kthread as well, if it's done
kthread_use_mm().

If the current check for "is kernel thread" was using ->mm to gauge
then, then the current check was just wrong, period.

-- 
Jens Axboe
