Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FA56C656;
	Wed, 23 Sep 2026 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196798; cv=none; b=hPqCO1j7tgf3alI2Tpk+woz/NijoFEL00wu+R8U25qX3nqpmI+4nPitAA/SO1ymLe5WXFwDysU+jZts6KBm0DB3zQVv6poTteMZhKOLicQ9rSl1mMVAOW10ytROFVhfpqZydmPC77Bnryk0JrRyNr7eyMPYcka4fHz8tXjcBnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196798; c=relaxed/simple;
	bh=gvkBIwlpuKf2zbfq3IB5OsZdYhL4aha6MJt1jdnJmp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKNDD/J0h+Mvmget4iJHSgQFDIAvLtCyvmDtjK4SFtB9NTZ5FqNVkylfdz21++D+OoCrGhS2apRasnKEd0KE0+u6ibtNXZpwDkCm+PDrbJ/2rkfZTDQzMEFEBMREUlym1KG/xjZenjSmW4LkrhnIU/ixFNbfkY88jVPoy4h1RmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VZ8o6pGj; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VZ8o6pGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790196748; x=1790801548; i=w_armin@gmx.de;
	bh=v8NRrgHMXi8+HsQftD6fR7mora2ZqNyrd9EX2fSfU80=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VZ8o6pGjjcB5UhJ8MrgLZkJotWK7iicMU/Fcpp7OiO5MOQSNakJ61LI7JcfTbIuY
	 19njRFUe9Qs/RjoMR4gvr4qnX08KdnWiFx0i/HrqYjDgQbBUMHG2qw5X6DX+pEMKk
	 nW12eEn1BJpN9Wh7Qk5a7dbT0597BiWqKDDgFUtVUPFLBOt7BSoMyK0pWsrFi8gXF
	 MRT9rR/KGWcybe2b6CvzwUSKBD0//trKAJFkVq7IDYLerNdZXPdRHVDhcxd/5y/mf
	 2j+cWLRjsjXQU3xeQV9xRH+0gwl50rHJyHwtPqaiWKwbjMqDbg/nKOcnjjM89csdZ
	 z3fh3vCmcqM1oh7geg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1weq7v3pY0-015dxx; Wed, 23
 Sep 2026 22:52:28 +0200
Message-ID: <d87fab8e-4f2b-4436-adab-f26782adb474@gmx.de>
Date: Wed, 23 Sep 2026 22:52:23 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Richard Weinberger <richard@nod.at>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org> <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2026092321-province-yearly-44aa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ie2HdETB86El3wsLqazN2n4+oLS3Buc1NZznJwFjnpf2VhVcNtQ
 kQCWGqv5UMHAOcMwiFUO3COf18yzIoyFIVbhsl/9q/+SkIu+giboId/7Ob8fvpS936gsxNr
 9sEQo3xP+fe2U7HJo5VePgxdXIT6QdR3k63FcSFhWkfLmdngRw+RY2oVrrhgjTm3Ew0/mob
 yAjKFykBdgMmq2JaxzZsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CfMAKQ81Gpc=;LKYnCDV2QlJxYk2G0ZhPnRKAfyc
 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

Am 23.09.26 um 11:27 schrieb Greg Kroah-Hartman:

> On Tue, Sep 22, 2026 at 11:04:46PM +0200, Armin Wolf wrote:
>> Am 22.09.26 um 15:40 schrieb David Lechner:
>>
>>> On 9/22/26 2:39 AM, Uwe Kleine-K=C3=B6nig wrote:
>>>> On Fri, Sep 18, 2026 at 06:39:02PM +0200, Danilo Krummrich wrote:
>>>>> On Mon Sep 14, 2026 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
>>>>>> The ability to add and remove devices from a driver through the sys=
fs
>>>>>> "bind" and "unbind" files was created all those decades ago as a wa=
y
>>>>>> that kernel developers can iterate faster, and provide a debugging =
way
>>>>>> for users to attempt to add a new device to a driver without having=
 to
>>>>>> rebuild their kernel.
>>>>>>
>>>>>> This api over the years has been abused and recently come under a m=
ajor
>>>>>> fuzzing "attack" through tools like syzbot which decided that it wo=
uld
>>>>>> attempt to just randomly bind any driver to any type of device, cau=
sing
>>>>>> loads of unneeded errors and pointless kernel patches to be generat=
ed by
>>>>>> unsuspecting new developers.
>>>>>>
>>>>>> Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, w=
hich
>>>>>> will be set on the driver if the bind/unbind sysfs files are ever
>>>>>> written to.  This lets kernel developers "know" that a user is
>>>>>> attempting to do something that is not normal, and as such, if the
>>>>>> kernel breaks they get to keep the shiny pieces laying around on th=
e
>>>>>> floor.
>>>>>>
>>>>>> The flag is 'Y' which was unused, and can remembered as the user is
>>>>>> "yeeting" the device being operated on here (thrown with force with=
out
>>>>>> regard for the thing being thrown).
>>>>>>
>>>>>> Note, the taint flag gets set _BEFORE_ the bind/unbind callback hap=
pens,
>>>>>> as many times crashes/oops/warnings/failures happen within the call=
back,
>>>>>> and the taint flag needs to be there to show what was being attempt=
ed.
>>>>>> If it were to be set after the callback happens, the oops report wo=
uld
>>>>>> not properly reflect what foolishness was being attempted.
>>>>>>
>>>>>> Fuzzing tools like syzbot, that doesn't have hand-crafted rules to =
keep
>>>>>> the tool from hitting bind/unbind, should be run with panic_on_tain=
t
>>>>>> enabled so that they fall over and don't continue on, thinking that=
 they
>>>>>> actually found a real issue.
>>>>>>
>>>>>> Userspace operations that rely on the bind/unbind files
>>>>> I agree that this should be avoided.
>>>>>
>>>>> But I also think the biggest offender really is driver_override. Spe=
cifically,
>>>>> on a hot-pluggable bus a driver must be complient with the device dr=
iver
>>>>> lifecycle rules and hence shouldn't break on bind/unbind. I think it=
 would be
>>>>> nice to not taint the kernel for such busses, and only taint on driv=
er_override,
>>>>> as I think we'd still want the bug reports for such cases.
>>>>>
>>>>> But I think this is fine to leave for a follow-up.
>>>> I fully agree. I'm fine and support tainting on driver_override, but
>>>> bind/unbind are used occasionally in my bubble and I consider drivers
>>>> not handling that properly buggy.
>> I fully agree with this, drivers should correctly implement the lifecyc=
le model
>> and not just break when being unbound at a improper time. Drivers suffe=
ring from
>> this can easily break this way when unloading the associated kernel mod=
ule, so this
>> taint is no solution.
> It's a "solution" in that it tells the developer "hey, the user did
> something odd and unsupported".  rmmod is also not a normal operation,
> there's no requirement that it actually work as it's usually a "best
> effort" type of thing.

 From my perspective rmmod and friends are at least expected to not crash =
the kernel.

>>> In the IIO subsystem, unbind/rebind is the de-facto way to reset a wed=
ged
>>> chip.
>>>
>>> A few examples where other reset methods were reject in favor of unbin=
d/bind:
>>>
>>> https://lore.kernel.org/linux-iio/20240727160216.2488ed29@jic23-huawei=
/
>>>
>>> 	This needs documenting as it's custom ABI. Note that we don't often
>>> 	accept custom ABI. Particularly not a hook that seems to reset the
>>> 	device. If you want to do that, unbind and rebind the whole drive[r]
>>> 	so we are in a known state etc.
>>>
>>> https://lore.kernel.org/linux-iio/20240720163440.03c713dc@jic23-huawei=
/
>>>
>>> 	Firstly as stated below, we don't provide interfaces for this
>>> 	because it's a heavy weight process that is most of the effort of
>>> 	unbinding and rebinding the driver. So if you need to reset, do that.
>>>
>>> https://lore.kernel.org/linux-iio/20250505200609.54756520@jic23-huawei=
/
>>>
>>> 	The solution is to run it once at driver bind. Similar to reset
>>> 	below, if the usecase needs to re do it then unbinding and rebinding
>>> 	the driver reflects the fact we are taking it effectively offline
>>> 	for a while.
>>>
>> I also consider bind/unbind to be an official API to interact with devi=
ces,
>> so i want to use them in the future with the WMI subsystem.
> Why?

Netlink UAPI <-> generic driver <-> WMI device

User will need to manually bind the generic driver (it really supports all=
 WMI devices!) to
a given WMI device, something that is only possible with bind/unbind.

>> AFAIK the underlying reason for this series is that some drivers break =
when
>> being bound to unsupported devices. However IMHO drivers should verify =
that
>> they support a given device inside their .probe callback, and the assoc=
iated
>> bus should only match devices with drivers that explicitly claim suppor=
t for
>> those devices (ignoring driver_override).
> No, drivers should NOT have to do that in their .probe() function,
> that's what we moved away from decades ago!  The match function should
> handle all of that for you, otherwise it's contant duplication
> everywhere that is unneeded.
>
> Please, learn from our history, don't make the same mistakes.

I meant with that, that drivers should be prepared that for example of_dev=
ice_get_match_data()
returns a NULL pointer. In Rust drivers would have to check for this anywa=
y, so i see little
reason why drivers written in C should skip this check and as a result bre=
ak as soon as someone
uses driver_override (or they are matched against a non-OF device).

> Now I might be convinced that driver_override is the way to go here, but
> it still feels really odd as again, bind/unbind was created as a driver
> debugging option only, it should NOT be a normal operation that any user
> should rely on.  The driver should "just work" properly instead, without
> requiring manual bind work, as that's not a good model at all.
>
> thanks,
>
> greg k-h

I understand your concerns, but IMHO it turned out that bind/unbind are us=
eful
outside of debugging. I agree that userspace using bind/unbind should not =
be considered
normal, but in my opinion its far from being suspicious. Manually unbindin=
g a specific drivers
in order to bind a generic driver is unusual, but understandable.

I agree with you that driver_override should be the correct place for such=
 a taint, because
using driver_override indeed overrides the bus-specific matching logic and=
 can therefore
be dangerous.

Thanks,
Armin Wolf

