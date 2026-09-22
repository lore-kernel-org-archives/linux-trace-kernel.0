Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732451EE1D;
	Tue, 22 Sep 2026 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111127; cv=none; b=mPNA8SVif7mOa9d3B1KySrj911KdgTtgt4JGCcwa2I2PnKZJWZXP7QqAWtTWpd9f6PCnaCfOW4zP4Rb5mzZDJPBALlQ+ePjWPB2OfmHnlKnXwg9rt3e893MEZUODBDWiTy0zSHXEjvYfNYrghTXfS9TnVpPDhMajl1W+T8geJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111127; c=relaxed/simple;
	bh=9Dv0Y/BGh3R8PeSvjophk2YPpeulfdBgLbKzqOhLo4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEApja8Rw1sEdn0ls2fozz/1domfambFEQAFTUGpRVdZpAh+DTlMEVJETUCTaKkiF1dD89AE3Q9FZ1vLTjBzsEzJv5Dy0pplyox0Xv+gk1/jlboz/w9K0x4YH0+ew1EpHmUIP+rGWd0mU4bx5H+ljbeVAZ66GkmeBgP7iZmTU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BVPf6FMy; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BVPf6FMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790111089; x=1790715889; i=w_armin@gmx.de;
	bh=HPj6QE4B/HefE3yLab3sUv06uJRi8t/2qBCqZDYS9/A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BVPf6FMyTeIyxJMRjkg4iy0eYXktcUzQwdvMkeZ7WJAxtCckYxOGRZ3tTnvXwj5J
	 +MhhbNRexm4GKX7XJxofDjMyztapU8G93s33wGkwg758e/YJxMqfr7g1CTlV5xWCn
	 9gtodpcZWuMtHXc4IepVXto86qHxeo/p6kN6+msHm/334a5uXA7oG1rP2tXvbD+yd
	 mw5fG7rCLZNlbwug98cynB5QYfy0ovFIxss11iE+AMOYY39/3OdTd+5wHCpNpLf+B
	 59EYHM+UkKCPoOPGOAj7pWftPeVvQO+oHd9yZhW5DRZIPWmb/wmFYVK5W7/oPb0uw
	 0umH3cvZ6h0J6AQb2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1wwSD040xC-00HAHh; Tue, 22
 Sep 2026 23:04:49 +0200
Message-ID: <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
Date: Tue, 22 Sep 2026 23:04:46 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
To: David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Richard Weinberger <richard@nod.at>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org> <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WC7Q3H3s8ZsHb6GZdlAH2xhbLNtKPMe9amNYtSfQcE1J7vdyDAD
 oaZxnVdrivGNmsT1JMOr3xUOZQxBJ8xLk6rh2KvA9bA8/6tc+D+LysIS906O/DpMgKS+ktn
 l1Kdz2RqzTEneLk5opZq55AEXwMmUeKoQ/eku4K1a3dtOjllrJ1SIufdF46AndHkdZsK7TY
 1YrgmsEz6BLYETy1qazqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PuQ2TbBFUU0=;SPWpip2IlpAv3IU5dtJ3vj3wwSh
 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
 Mbz06IpVbstePJ/LEY8LXhgweA==

Am 22.09.26 um 15:40 schrieb David Lechner:

> On 9/22/26 2:39 AM, Uwe Kleine-K=C3=B6nig wrote:
>> On Fri, Sep 18, 2026 at 06:39:02PM +0200, Danilo Krummrich wrote:
>>> On Mon Sep 14, 2026 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
>>>> The ability to add and remove devices from a driver through the sysfs
>>>> "bind" and "unbind" files was created all those decades ago as a way
>>>> that kernel developers can iterate faster, and provide a debugging wa=
y
>>>> for users to attempt to add a new device to a driver without having t=
o
>>>> rebuild their kernel.
>>>>
>>>> This api over the years has been abused and recently come under a maj=
or
>>>> fuzzing "attack" through tools like syzbot which decided that it woul=
d
>>>> attempt to just randomly bind any driver to any type of device, causi=
ng
>>>> loads of unneeded errors and pointless kernel patches to be generated=
 by
>>>> unsuspecting new developers.
>>>>
>>>> Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, whi=
ch
>>>> will be set on the driver if the bind/unbind sysfs files are ever
>>>> written to.  This lets kernel developers "know" that a user is
>>>> attempting to do something that is not normal, and as such, if the
>>>> kernel breaks they get to keep the shiny pieces laying around on the
>>>> floor.
>>>>
>>>> The flag is 'Y' which was unused, and can remembered as the user is
>>>> "yeeting" the device being operated on here (thrown with force withou=
t
>>>> regard for the thing being thrown).
>>>>
>>>> Note, the taint flag gets set _BEFORE_ the bind/unbind callback happe=
ns,
>>>> as many times crashes/oops/warnings/failures happen within the callba=
ck,
>>>> and the taint flag needs to be there to show what was being attempted=
.
>>>> If it were to be set after the callback happens, the oops report woul=
d
>>>> not properly reflect what foolishness was being attempted.
>>>>
>>>> Fuzzing tools like syzbot, that doesn't have hand-crafted rules to ke=
ep
>>>> the tool from hitting bind/unbind, should be run with panic_on_taint
>>>> enabled so that they fall over and don't continue on, thinking that t=
hey
>>>> actually found a real issue.
>>>>
>>>> Userspace operations that rely on the bind/unbind files
>>> I agree that this should be avoided.
>>>
>>> But I also think the biggest offender really is driver_override. Speci=
fically,
>>> on a hot-pluggable bus a driver must be complient with the device driv=
er
>>> lifecycle rules and hence shouldn't break on bind/unbind. I think it w=
ould be
>>> nice to not taint the kernel for such busses, and only taint on driver=
_override,
>>> as I think we'd still want the bug reports for such cases.
>>>
>>> But I think this is fine to leave for a follow-up.
>> I fully agree. I'm fine and support tainting on driver_override, but
>> bind/unbind are used occasionally in my bubble and I consider drivers
>> not handling that properly buggy.

I fully agree with this, drivers should correctly implement the lifecycle =
model
and not just break when being unbound at a improper time. Drivers sufferin=
g from
this can easily break this way when unloading the associated kernel module=
, so this
taint is no solution.

> In the IIO subsystem, unbind/rebind is the de-facto way to reset a wedge=
d
> chip.
>
> A few examples where other reset methods were reject in favor of unbind/=
bind:
>
> https://lore.kernel.org/linux-iio/20240727160216.2488ed29@jic23-huawei/
>
> 	This needs documenting as it's custom ABI. Note that we don't often
> 	accept custom ABI. Particularly not a hook that seems to reset the
> 	device. If you want to do that, unbind and rebind the whole drive[r]
> 	so we are in a known state etc.
>
> https://lore.kernel.org/linux-iio/20240720163440.03c713dc@jic23-huawei/
>
> 	Firstly as stated below, we don't provide interfaces for this
> 	because it's a heavy weight process that is most of the effort of
> 	unbinding and rebinding the driver. So if you need to reset, do that.
>
> https://lore.kernel.org/linux-iio/20250505200609.54756520@jic23-huawei/
>
> 	The solution is to run it once at driver bind. Similar to reset
> 	below, if the usecase needs to re do it then unbinding and rebinding
> 	the driver reflects the fact we are taking it effectively offline
> 	for a while.
>
I also consider bind/unbind to be an official API to interact with devices=
,
so i want to use them in the future with the WMI subsystem.

AFAIK the underlying reason for this series is that some drivers break whe=
n
being bound to unsupported devices. However IMHO drivers should verify tha=
t
they support a given device inside their .probe callback, and the associat=
ed
bus should only match devices with drivers that explicitly claim support f=
or
those devices (ignoring driver_override).

Can we get some example bugs uncovered this way?

Thanks,
Armin Wolf

>> So please let's do
>>
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index c51ad96d4de4..ce8fb14ea19a 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -242,7 +242,6 @@ static ssize_t unbind_store(struct device_driver *d=
rv, const char *buf,
>>  =20
>>   	dev =3D bus_find_device_by_name(bus, NULL, buf);
>>   	if (dev && dev->driver =3D=3D drv) {
>> -		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
>>   		device_driver_detach(dev);
>>   		err =3D count;
>>   	}
>> @@ -266,7 +265,6 @@ static ssize_t bind_store(struct device_driver *drv=
, const char *buf,
>>  =20
>>   	dev =3D bus_find_device_by_name(bus, NULL, buf);
>>   	if (dev && driver_match_device(drv, dev)) {
>> -		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
>>   		err =3D device_driver_attach(drv, dev);
>>   		if (!err) {
>>   			/* success */
>> @@ -513,6 +511,7 @@ static ssize_t driver_override_store(struct device =
*dev,
>>   {
>>   	int ret;
>>  =20
>> +	add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
>>   	ret =3D __device_set_driver_override(dev, buf, count);
>>   	if (ret)
>>   		return ret;
>>
>> (plus the needed documentation adaptions and maybe a rename
>> s/TAINT_FORCED_BIND/TAINT_DRIVER_OVERRIDE/).
>>
>> Best regards
>> Uwe
