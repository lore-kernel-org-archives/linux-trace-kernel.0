Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDB4B5A6;
	Sun, 12 May 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715533989; cv=none; b=dk7JGY05rLqJkq2ajnb8P2oMpdZ818N/fjSx49FVI0AGorQfuWxp/PcAv2Ul8bwA5e/Sv/xVpOoTfBtlYoWYPIEooAyqNSclwpFO1g4ycygh8netBBrvxxxoWY1zpo1g4tu9NlrWR240P2dygzGJyN36Ov93dKGreRMROVj5qXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715533989; c=relaxed/simple;
	bh=VDSb4DbMpc1FY1UtGk9RbyFh7cLMhvTk2YjT8OE06Y8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BrVfhOvL5DAVBOsyi6OA47uP1mxoBmJkF8n5tr2mbJNKHQPRC0NVbq43amqjOq/wZH15n3me6VAmNRpyWjrzw7pH9hzd3xGf4BnxcwPcrY50oVZCrxGc4kWfOcKJWNY4t647wIzWL3FpkXWDvC0B9usdGhtpajz8BpVN1wJEaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=U4cId8CD; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="U4cId8CD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715533956; x=1716138756; i=markus.elfring@web.de;
	bh=qcThUF06zC9osZK76mN+mMVo2ws1e0dYwDrXjIgp0WM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U4cId8CD2ANuydclzA3kWTobo8MZNoEhKBevF78ibF8GvlzR0re8dlKBhF9RsccS
	 6WAheIhwudGMfjEAKOHEx2KvrA6mJeXVeIRk886k2Xs8RpwbIKrAX87zBGpPW6Oa8
	 Cy2PhsG3IQzFjMmcaRTCm7vP2BJtwRZipKo4SOdt4CODUSHmJ5wxEdPKPO+s/bzk/
	 kv5O5mhvAjuIF7rRE6TuUh+WGP5GgjX7abEV4SZY1tpHZMeF0Rpe+T9xgs2xmB2Y7
	 fJx0H9wJl9CEx0aU7kbvEQrfz9ZjS08pCr4uTMJebmu6UK4EK1/RUGMLEAC5651HY
	 nDJQ8FtFNir4XKxqUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1s8wqE2Vq6-00H3K2; Sun, 12
 May 2024 19:12:36 +0200
Message-ID: <34c7ffeb-1fe9-4e89-a7b6-c6a8be17df90@web.de>
Date: Sun, 12 May 2024 19:12:20 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hao Ge <gehao@kylinos.cn>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hao Ge <hao.ge@linux.dev>
References: <20240511024255.34767-1-hao.ge@linux.dev>
Subject: Re: [PATCH] eventfs: Directly return NULL to avoid null point
 dereferenced
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240511024255.34767-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YJ0QvveAYIQ2kv+x3SshdYGgo8Z5AaQYcpxaqUcvLgas5BPC1+Q
 yL6w/Ssrgbn4E/gxTyrx8lX777uQx2ISr4JB07wZBWRzZspOv9kJgDO99hMReE5nEwPYRbx
 6fw04kW3AU1eW5CEJtvSC6aYPAwgbz+PMKzqPy1Wur/qUurE/VBgt55f7riw+VNKWufO16K
 37cpFFPtfakxqrgMn3rDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/rt3hg9wDxo=;lMiyN6KiDxzUuuT69+fJAMVnf69
 6NhqHDh+ChhgyGsipE/IzRwQyZ+no7qNzgzTF6rAMUQDE1q5DOvftZ1896ln/hbTx/MBqqF2i
 TD1BQFGcx32XSDDd4INrLdHoEQzfZ5YCN2xRwYD+KldKLps4aRlFUv6ojCLy94GwvhxDr/oXI
 MZIQGHsfw7dv/Z/z77OmRPUwyz49QpgQTq0I272LQxieeDZokRw0wQPhZSmGErJjHkYegvqAs
 Pmh+GyNyUjavy/z/f5moUFys71gvJaOGgpwftsKDoKIXjzIW3G2JBDHyWcPFBz3OOfNK9KNdL
 AXM3VOFYRDWBxyRGLFvpska64oTu7PN51ux55vh7Tz/tvhCnebeMYk3YtkvjAH5hP5AyGQAxr
 sRxVJoEQokD/uJr8Sbi79TAgOiNtQXzMUq8FKXV1VMcKJUu8u83AEtJf9GWXNesvjPJ4FFYqH
 7CKy+RECraT/CXjZ1uQrLBDPMcRKuZj5M8Uk2TypRUsUo31pZ+o2V81BY20wiMNXD6aRDeNGX
 KCK6KsF6/KKbMRAbK7hTP4PkkKaGZvRuDSDurHV+f8Kg75W6f4a1w6m8+ByIFpfglmkehYkoE
 r+wzhUH0I0FLfAycC7q0D1kbfpwP2h2xsvNQ4CAvpsv5/LqXX3Go0ZCVbt2yH/n4iuBtZtRec
 OHIwlfwyd2IwdvV1Ayn/ujtHKy+mVcD9MQklDYFhTRhj1Aw9oO+HHJcaLPqXF2eEfj/WKnCE1
 V3NbU4pxV0wq3ibiso0Wp1Vn5LgjMQco52gHnJq79ToKgOMiAmSrXUSFWysqJ1VpsR3NBlIB/
 07uokY59xhAoCArWMFb2HN7l7RCUNhO0u9rVON7mM1YDk=

> When the condition ei->is_free holds,we return NULL directly to
> avoid update_events_attr to use NULL point about ei.

* Please avoid typos in the summary phrase and the commit message.

* Would you like to use an imperative wording for an improved change descr=
iption?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94


=E2=80=A6
> +++ b/fs/tracefs/event_inode.c
> @@ -346,8 +346,7 @@ static struct eventfs_inode *eventfs_find_events(str=
uct dentry *dentry)
>  		 * doesn't matter.
>  		 */
>  		if (ei->is_freed) {
> -			ei =3D NULL;
> -			break;
> +			return NULL;
>  		}
=E2=80=A6

How do you think about to omit curly brackets here?

Regards,
Markus
