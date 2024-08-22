Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90518EB1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362880; cv=none; b=PaNa5Leg5FBKCJTSSSINZVYmWUzJ13xQZIfexBBuLa6WMNe7jJKVkX4myEixpHiK1Ywna1bnjfAyxdYBg6AzWOXrEowAW5Lthnm21TD7FIPI8z1ejtxrMuQelJ0RmFAQ5+y21iWGSzZchhddgG4922NATeovHUIFhLeH4OSlkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362880; c=relaxed/simple;
	bh=ys39fHXJ80d5zS9l6XXUcl0mUspJPf/fAq1lPld/hXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QPU1ngBu7UtcdFRoz64g5+LAUBT/iDjZTbrg3N9yS7BF2Bbv/2MatRMb3KmUMfGqx8O1LEd0pimSWIoaXlv1x4pbT24gKQfZF9XsyzlPNCBlwApAKcxqQt6Zn0nOQeBUb/JM3NqWkyx1oI9uuglATfYDNDViPUwiBpSDqe9WVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKb1yZPT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=okKOQnxz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKb1yZPT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="okKOQnxz"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724362877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYh+FUuld+A4T0yc05XEIVg6RdWwFfiXCbS7WX6Xoik=;
	b=oKb1yZPT7/TTwf3uDRvxpg5RHj9gYXIMyYcdMOsclOEqzjK714926rTB8yC+p1Y+PXwFXI
	nkJwScMhFcrAmdeVMaejFB/UlQ34JTPsuw/7ZlNB+LgGwtwH8rxiivb/flXipMscA5wkF3
	OcHycoGf67ilsRiXbl5Z22zbZtTGZ/ErRvHADZp7WlU+ZdT8B4NV/hgGD9xzj9kaU30ei5
	POQ9yn5P0+xuu14VJDCPnHlcTDMDQR5PWhK9mjExsjZEN3merHHH7fSCZXbOQBCAzdjKwm
	/VJ/r3NV6j+tTzU34Ab9ycyLTttjvC8Plp3JNSCKpJgpO6lXaaXVVMTLOZE6pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724362877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aYh+FUuld+A4T0yc05XEIVg6RdWwFfiXCbS7WX6Xoik=;
	b=okKOQnxzjUnhxl7+uHdO/zRLdFI3HKQ4LM0nAZTmaDEA5pq6lheHOsqghRFHmI4b6h5xZ6
	k7kvvj9AWaZ1gWDg==
To: John Stultz <jstultz@google.com>, Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org,
 oliver.upton@linux.dev, kvmarm@lists.linux.dev, will@kernel.org,
 qperret@google.com, kernel-team@android.com
Subject: Re: [RFC PATCH 04/11] timekeeping: Export the boot clock in snapshots
In-Reply-To: <CANDhNCoWvBn=h3ENEM9bbJO8LBVh5m=3vw79Bawr3e4NE4UMSQ@mail.gmail.com>
References: <20240805173234.3542917-1-vdonnefort@google.com>
 <20240805173234.3542917-5-vdonnefort@google.com>
 <CANDhNCoWvBn=h3ENEM9bbJO8LBVh5m=3vw79Bawr3e4NE4UMSQ@mail.gmail.com>
Date: Thu, 22 Aug 2024 23:41:17 +0200
Message-ID: <87le0ogrr6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22 2024 at 11:13, John Stultz wrote:
> On Mon, Aug 5, 2024 at 10:33=E2=80=AFAM 'Vincent Donnefort' via kernel-te=
am
> <kernel-team@android.com> wrote:
>> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
>> index fc12a9ba2c88..0fc6a61d64bd 100644
>> --- a/include/linux/timekeeping.h
>> +++ b/include/linux/timekeeping.h
>> @@ -275,18 +275,24 @@ struct ktime_timestamps {
>>   *                              counter value
>>   * @cycles:    Clocksource counter value to produce the system times
>>   * @real:      Realtime system time
>> + * @boot:      Boot time
>
> So, adding the boottime to this kernel-internal snapshot seems reasonable=
 to me.

Maybe for you, but I have zero context to this as this submission
obviously failed to CC the relevant mailing lists and maintainers...

Documentation/process is there for a reason...

Thanks,

        tgkx




