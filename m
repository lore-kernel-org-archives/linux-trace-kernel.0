Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2A13FD72;
	Thu, 12 Dec 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038091; cv=none; b=spv0ayJXlp3wyeyHHYItf241YgCV/4QN3BcOJEHJHZaSAxs8mIq08iLKNJ7prVBbftQRJQZyOjUvCXYztShewpvmEr7dQinFj7OPKBARRXOIIhtjIoAGbvMGarhu7snqvRJfyxl/htAMf+5L2DJJBraU9tOVMw1z14mK4Lc+qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038091; c=relaxed/simple;
	bh=T4urowiJ2qizH6LDk0ZS8i32It4fsmj9/7Poghekv1o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=G7zU+Lfv1sNAyFWmz+heiKTV8b1UMf81MqGtAXS8yfamaBCBRLzlkF8UzXigLGLZ0DfDRuF4yIekSx3jFgJcYQ5ESPMpnqC7OL1LX1EPrdxkW3AHrALtaCD3d1QlPSWJ4MdlLS9N5R3hNhzj8+EVAT6JLuFx0Pm0p6/0BtNOkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id EB6B1A09A2;
	Thu, 12 Dec 2024 20:56:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id C69626000E;
	Thu, 12 Dec 2024 20:56:18 +0000 (UTC)
Date: Thu, 12 Dec 2024 15:56:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Walleij <linus.walleij@linaro.org>
CC: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] fgraph: Still initialize idle shadow stacks when starting
User-Agent: K-9 Mail for Android
In-Reply-To: <CACRpkdbrJ6ERLeMxBPXykCk+mgUkiYGVYqVSnTCKzu=9DBgy6w@mail.gmail.com>
References: <20241211135335.094ba282@batman.local.home> <CACRpkdbrJ6ERLeMxBPXykCk+mgUkiYGVYqVSnTCKzu=9DBgy6w@mail.gmail.com>
Message-ID: <81D30FDF-BC8A-4189-A1D1-25BB66C19172@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C69626000E
X-Rspamd-Server: rspamout03
X-Stat-Signature: hd7xhry7uz1a5famsq1f1z6kgdxtnjzf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/HttJSC/SNhmg9CSbz18q9TbTnZTYLSVE=
X-HE-Tag: 1734036978-984619
X-HE-Meta: U2FsdGVkX180CCpS5Wz+zFpi3eIDVcaZpBq4w+SwBPKQKA2Df7xHQ0t1lOLXuUjcd4Fc8RRuVBshMriDhkGCK7MRjkl3qZTKzmNLYDUJlWnGQULV9DH9CeGh06BOkhP8l9exna5kBYSiUCfTLTuLvRascvdXiwpPfg5IvZDqhh/2xJtVLlL/6qQGzQGlwy+PfelElAzh3za0b/A6HQJnO5QZZBtk6Cx8rrmvdo2v7g8bCnCMfBvvEycu0f29I7d87cfHCLJ0YrhAChQM92QxhN/2dlyKuDakPV1tV0atzG6AgwdadPW85DYl3rIDPVYcnSTuv69tG0YODSgpGuumZSAslxWhFRgDxMDlYLXelaJrxlDlae/RJza4eiTXWrrSxi+vvCp1N6Ex0evLxEx4bPaa3tWpP/JBDujfTY72UdncKnuzJvZ2PlqrHdDC81FOmJ3qd+eRJIKDlyYkknCTvIxOERxsyYFg7xF1CoVR88tOnYmKQ8pijW76J7pV14eh



On December 12, 2024 3:49:37 PM EST, Linus Walleij <linus=2Ewalleij@linaro=
=2Eorg> wrote:
>On Wed, Dec 11, 2024 at 7:53=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
=2Eorg> wrote:
>
>> From: Steven Rostedt <rostedt@goodmis=2Eorg>
>>
>> A bug was discovered where the idle shadow stacks were not initialized
>> for offline CPUs when starting function graph tracer, and when they cam=
e
>> online they were not traced due to the missing shadow stack=2E To fix
>> this, the idle task shadow stack initialization was moved to using the
>> CPU hotplug callbacks=2E But it removed the initialization when the
>> function graph was enabled=2E The problem here is that the hotplug
>> callbacks are called when the CPUs come online, but the idle shadow
>> stack initialization only happens if function graph is currently
>> active=2E This caused the online CPUs to not get their shadow stack
>> initialized=2E
>>
>> The idle shadow stack initialization still needs to be done when the
>> function graph is registered, as they will not be allocated if function
>> graph is not registered=2E
>>
>> Cc: stable@vger=2Ekernel=2Eorg
>> Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize i=
dle shadow stacks")
>> Reported-by: Linus Walleij <linus=2Ewalleij@linaro=2Eorg>
>> Closes: https://lore=2Ekernel=2Eorg/all/CACRpkdaTBrHwRbbrphVy-=3DSeDz6M=
SsXhTKypOtLrTQ+DgGAOcQ@mail=2Egmail=2Ecom/
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis=2Eorg>
>
>Yep that solves my issue and I can go on debugging my boot!
>Tested-by: Linus Walleij <linus=2Ewalleij@linaro=2Eorg>
>
>Thanks for patching this up so quickly Stephen, you're the best=2E
>

No problem, but I don't know who this "Stephen" is? ;-)

-- Steve

>Yours,
>Linus Walleij
