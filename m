Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17621C169;
	Fri, 20 Dec 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713781; cv=none; b=HNpzoUplvjXnhoeSeub7yzkhvBMVqhCi/T4TrnW2W7U1q/GS/vbnsoFGmUfNKFMia6B6CbBuu8KQ9CfqHGNSJL7DqGaVB1WvMcH5WNI702CzoacPJdw14VaBMSbJJ0dQrm9xtcmGPShx973rP5sOnNA6ETDjynZHIALh0nPkW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713781; c=relaxed/simple;
	bh=gTYfuTkKcQgWqJzyTQkXUaLNY4/gTGVq5GOLK/6khNE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BMfoEvVOp100B/K7tyyTZyvHFTE3Bu0qb26ajfXRU0JzdOW9UMByIPnfiA6arhf5FW4FWp/wfAyjSCTzXVnuhzkSeEbWI9HazMJgvXTdbBVa3f6UIWKP8D94kVJXw7gmZfg8dCDBT2wF0umhWDdGwmSKZnpMsQ+3TymWRcjyEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tA4AP7Bv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tA4AP7Bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734713766; x=1735318566; i=markus.elfring@web.de;
	bh=gTYfuTkKcQgWqJzyTQkXUaLNY4/gTGVq5GOLK/6khNE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tA4AP7BvI9Yc5XIKyYhjBz9ZZJclQYzdwBKRypwgIyxc5hplEBa1s4lJKEZy+Iw4
	 kQbuXk3y+IfGUk960RlDW1y6Jc2x/owbVjqRcEjWqQa3MUoAruyG/Pk7q21ZU7eZd
	 hQqARzS72aoXLTorNd+9cQ3JSe5+FBIALArNTYs2RLTMV+r7DiltncN7zAzNISehe
	 nA9tZPWL4tfNdtUmc7BeJHomFwjdRR+0HNBqkD43SHO/fQiUdV+92WRWtkyzWf7Oe
	 2NgaQqEHUqV/tbuE+FUszO1XeMlLewK4NrmbdQK1z4lDkFeA9p04HFgmEnxB2leOH
	 R7XDN4ytYCN+8i1FXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJFdP-1t9dU51hNL-00NL3k; Fri, 20
 Dec 2024 17:56:06 +0100
Message-ID: <1157a6c9-0039-4077-9161-91aea6ab4213@web.de>
Date: Fri, 20 Dec 2024 17:56:05 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20241219201345.860391310@goodmis.org>
Subject: Re: [PATCH 08/14] tracing: Switch trace_events_trigger.c code over to
 use guard()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241219201345.860391310@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IDFSxyeClDU+XPUBtouliiAypw92ZJz1iC/j3aeBKaYjutGDYVe
 eg8MP/+tRzhx5HRXbds4UlS9WUWlL5lzXwA59Tsx3hWl3tu445Wi+32ZQzbxW/swle48EHU
 FVsyq+sUjpATE240EBfyDjq+fmjJLNgRdOIBgqDgBnFivNcd2uRsp8T7PYWDov3Er916ecr
 NZT0bLPAzvFnBObwy1SNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NpYzXubct1k=;OKJdRbwQiRf7hkjhhlR9zmGsyVW
 WywmuOS8GEknQwLlT3MV2ICta4xSDigo1YqBir4dUKXwmFca7CvhF4lb55MQjW7p3JK8husfV
 WUNswiJn//QcIL1k5LdjMlCmQzreJSxOz1rm33GQp9HJXzv4eQKyoMKwItjHYUVObe1abMd/+
 g+k/g1VggYRlRbYT1ggpjEm/7d1yNq7r2MlzHqhOM2jc3sUbVrtwlj/Y8p34HRmIO+C5NKKsO
 vVkDWRlXXDbS91aBWbI2eHHM8inL9Fry176tkNNw0mxD/WW4tqIiPgOI6OxmDN1uRiAcoPK6u
 p1GN0snxjbiyZHWPmHnDvsi0P9y/ZZAjqsuQW8TOwI3zP87qAPqy+7FnYSxiLivHpZCsC+q85
 hpczMo3JREUtaPxeU9Sh0xp7SzZXtzgBeuleXj63zBdRkvj8nePRPT9Hf/tZ2imk7v6szmOFb
 u9w5K8rl6TUJByJKjlZ/prx5rhS10tDgFwbJeqwdyTK3db8fXeGBagLFEt0XTQEMcyV7x3416
 O20DkxO/wtCDBwDZYbUxW4AJqgS19/ObzwCXhm76bwaF4B7BmwzJTUbtgmy4V+gnkFkRX/amV
 PZsoqFv0R44wYhhBdsiXqEMj0xbbje1vinbjzb1rfVKvTtEoAOTmi79PMjOhOfVgkcWfV8Tmw
 5BdjVsdWbx9stzA0+fH3+7AQ5W/04I2xaTr1lYPLbJhGKfpYICXDAokVNoz3Uk4oYspAq9Lw4
 Gv2nddUbxw/ORofGAdhys/dQShcUvc9y9d619e+8fjpNtc6jfhs9ndl4uwK8Y16MBnjExNEDD
 +rbKPHEUKxGQqi0tvQu7qUn88qmg953fnL7ALWzpQykJGWQ3fA+JWILVLfqUwL7D+1+Urt+Tr
 BiGdjnqEpeNpNHOLEogBjwvCJ1v3DwMjkdp2GVMmdFEGeGBa/3Uef8ODZkqCCe2kcXW6mkPa3
 WV51ZD8/Ev4fqeVjLg+HmlEFDn5o0N69UVRjN2ACEOpRtxldBfZ9uu4DbFwqNkZ8JdEotsWWT
 fJ93qasaZ8OMoby5ZtjF1UH8QOXRbYkRc/uQ4KV/A3J/P52AgauudpnCipazDqnWJhRh1rdC1
 JPN5meFh4=

=E2=80=A6
> Switch every location that ends with unlocking a mutex on error over to
> using the guard(mutex)() infrastructure to let the compiler worry about
> releasing locks. This makes the code easier to read and understand.
>
> Also use __free() for free a temporary buffer in event_trigger_regex_wri=
te().

Can it be safer and cleaner to split adjustments for these programming int=
erfaces?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n81

Regards,
Markus
