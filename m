Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAB471428;
	Wed, 22 Jul 2026 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706192; cv=none; b=rUrGIfImdMm0+oRDFxRHhC7JG2USLRVXyK9/bOCYD2aQXuirABWl37RUeM+JEU2M9PqO2QsoGMMqN3QKy+nThx2vofKrzIl0KPNBrdFKvT4ftbNPyAJateDPMc2yXJ1QV5PLzUbh4jAoyjUUeoODifXlm/8pFEWNsU5j6UbARmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706192; c=relaxed/simple;
	bh=QXdhVeU17roDKvCWhTaJzFIJxl5UYRYDeoq8D7fCOgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nr7QrzRHWzwIDEz3IpWEpuWq3QClU8eIkMb7wH9XRU6Ee7J0q0/3AcGZLD6mexljFEiVapbPJXzmcbYVNruuHskH4mBSYF8L+EZmLukAwIZMjaVpl7AORijxdHgv1S9YDp+RvdQBK12dCVV9RQYfnCV/P5QcpRS23LZnyDXh/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hjn1zt5X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TO11k9pW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hjn1zt5X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TO11k9pW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784706181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+uYsFTuBBKYeKLYfQzR0sOn5Iua/yKtJ3vlyKn/9gs=;
	b=hjn1zt5XUXSphZoAPraOAqhCc+Mr1sBI8qLojgz0WdPY9G0ciLqVGXITAgajVWnQYeyVw8
	SaPaFQkknsqfuKwn+yqOb9IQG6By2w7WrCRQShRDdn1NKyG80+V9NhdM+SyxvLxYnmrI8t
	MQozSk5Li+Gk0YqVGGH1zRR5q8Iq/1xXaidVHfLQbwiqaMzPKbJM28Yv9ogLb20K2SSMPO
	fHc/c8ZKJbrNA3ttNl0fDIGokGgP6KDFEi/WXQTsBT4ADps/9KpeQ8BXaX7YohjQRfhtom
	0BhcjzX7A5ZBXL3xdTR5IfdzRZkJx2a/MYgogiRs2bUeqnmfPFs7hVLzpXF5kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784706181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+uYsFTuBBKYeKLYfQzR0sOn5Iua/yKtJ3vlyKn/9gs=;
	b=TO11k9pWJ3ymoMRWqKOKM4tK6cvsYJb0QcMdvykNv0Ib0HS+/xSWnccZh9y/Qp/Xj42TJV
	dK6XhlpRicx43VBw==
To: Chao Liu <chao.liu@processmission.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
In-Reply-To: <amBHR4JTr2InJDk8@ChaodeMacBook-Pro.local>
References: <cover.1781852967.git.namcao@linutronix.de>
 <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
 <amBHR4JTr2InJDk8@ChaodeMacBook-Pro.local>
Date: Wed, 22 Jul 2026 09:42:59 +0200
Message-ID: <87y0f3wjuk.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chao Liu <chao.liu@processmission.com> writes:
>> +static void handle_sched_waking(void *data, struct task_struct *task)
>> +{
>> +	if (in_task()) {
>> +		if (current->prio > task->prio)
>> +			ltl_atom_pulse(task, LTL_WOKEN_BY_LOWER_PRIO, true);
>
> The implementation also reports wakeups from softirq context through
> WOKEN_BY_SOFTIRQ:
>
>> +	} else if (in_serving_softirq()) {
>> +		ltl_atom_pulse(task, LTL_WOKEN_BY_SOFTIRQ, true);
>> +	}
>
> Should this description mention softirq wakeups as well?

Technically, on RT kernel, softirq is a SCHED_OTHER task. On !RT kernel,
softirq can also be executed as a SCHED_OTHER task, which is the cause
for concern.

But explicitly mentioning softirq does not hurt, I wouldn't oppose that.

Nam
