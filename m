Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B665261B65;
	Mon, 15 Sep 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953150; cv=none; b=CasYJYbS7fvIh7ZQa7UUigbwIYTZv0XQ9ndWWs/c0fsRVZntYu5CL97/mDwzs7bV5mfy9uS+XdmVCEWvOTg37d6CdwTWeu7IgGks6Lz/VLy8/oe5WaWbcf4eqSEnWsGZbtg4BwcCdkQfzl0rBd3Z3rx6ogX0Cb70OW8c3ovNcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953150; c=relaxed/simple;
	bh=+MJ5Hs7FJ4tqj+YnGVPlozQOBbmZOzTWD34Wk0fsXqY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PlK8CIYUXKa8fPeuBto3RjBXyJKLbwCDXaXjqbuLlJiHXOLt5U/fl6CZbcBRNLr3Dn/lwO1HgoW26TXFKq0WsT4dALuOgiVCnYZAnt3pyD7EJQHZQF6Kk8KWVyJv8pqOk069+uOw9N1KZcRd82QcEjZVS9q2EZrHJgMQMLVxwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fzSoU7YW; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fzSoU7YW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757953140; x=1758557940; i=markus.elfring@web.de;
	bh=+MJ5Hs7FJ4tqj+YnGVPlozQOBbmZOzTWD34Wk0fsXqY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fzSoU7YW5xwOpJa2JPgagYWxxV5QOi/N/ohmVCzW7tMiU/FGXwR3dA2ibBwKwBCq
	 yVJBIbZ4+QgHOB+EHE+6pSOPbEJ/cmW61B5qRDtSXSRlXqZep7iPmv4haKYYrPYU9
	 l/gu9Iai3l/tx+w3AZHzb33fzZt4q1t5/MolAXAX/dTLYKyuq5y1POZNRy6zBFmB4
	 VyTzaCpEHRyrja9DseZgOYdb1DsmqK8ms6+OxQB0v+9D1n8KN5NvvwaOaSMro1T1x
	 gE71EA4p9sBT46IUWYSO8CYDer6G9y0YyZCCR5db2O/y45HlsSk6ViQi/wpvM4PFS
	 offjQaJkOP+8lLagCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.188]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5jv-1v7EST2P3J-00D86I; Mon, 15
 Sep 2025 18:19:00 +0200
Message-ID: <af11c51d-0e00-4423-b383-aa8e75e2b076@web.de>
Date: Mon, 15 Sep 2025 18:18:58 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wander Lairson Costa <wander@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>, John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomas Glozar <tglozar@redhat.com>
References: <20250915151807.40851-1-wander@redhat.com>
Subject: Re: [PATCH] rtla/actions: Fix condition for buffer reallocation
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250915151807.40851-1-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cIDmT2HCeExSR1/kLSLTVGaDD2DHIHbWnTy/uiwP75Ei8/GFojP
 ZjkpZsJvvo6VUMimxRRk0y/15c9Hhg7hrH58rOrpVBf+muuZN4xHnITP/0xl9aat2OAKrmi
 P9MwsyXkZag9N1qm2OR5B36hFGwesbQEQC32QJY4+L0DMIpseln7kuvnVjBfU7sXoRZDcuZ
 4jpiUtLV55MqUMZs759GA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4wqOB2X4U6o=;TVvDnIo5J4xhgKgJlZYZWpBJoEd
 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
 41kuXM32SIUDwwuCMKryoawQW0pjpt00y+KUt1U6lSeKqSxZGpZVlMuxWF5q00CBRqcHAikOh
 TFheHiYv3mo2wDMm1Mhm5mdquyXO9W2BGgbP5KLTwcE0wAYdA5gLQN5Uw6zgtXdwwcu0kYslr
 AjYDOp634lLAUcUiEDdMQNdi5pcRTpNbjWV12kQaNCZpwGmvORy3fwjx/Cbfuv+ON9zVW75NL
 +Azh9it11bspT8GewH/vVtZZZWKPkxgxoQDf3d2Clt/hDYoL/2GTxGaYy+NVcwRWZeCEz1Y31
 S/vISdEweJLeYAWhu4S+razYGtSglVKxA6TgbUrLroWXsVP4mZubun1laOZjmFxIqJCXjqLwV
 RHV8Rp3tje3dpAQw0UVXd+YqfKnnoNVkyeXLa9WQCweDDok9Wp2J8+fcXNG9E1YsfCwKU9MSw
 imh9ztNEDNzq9GU7L5+oXI8Dw1VU2z28k55qv90X11q1ZN2NPw2PP1dI9dT3JxzaNuSKFJeZ0
 vVnYj8I8I5lcev2wq8OHxVRo97bRodjaaEPfu75Z2fp21mZpJ7kvSr/2VFCxx3H3dH5e4v+cG
 TSrbQpwIhw1zL2gAs+uMXb1u08xc0kN3Srsbgudc5FbzlrC9vSo8z6lyyqUPnaebhR2+PWh6c
 L7z128DbJU3X4FaOva6KtVSZ20yjz7XDkOTCIiQhdY8KmTnLjzdW3K8n9o3V4Hk3v6RNuZ9QB
 oBhXziqSy1NO7R0+CL2EMJLSIFC6xFmvZuIrfCe4HuzrJwcaBgGGJsgNJxemoRH6RUWKU3xYM
 /Xih8LnQ+mTNKDZ/RLGIL6j/WAx1LofJL2UlkLMhPuF8cVakXvyjkv+wdOJTtHsG9pwPloycs
 YegyTGY2j0B8VOwC0tfZhPg6K+zMeoPPrjN7wUnZPeAjbNo7wD6fsH+KYaFaiIVQ87CSvEYFu
 x45XVcAAQ87Yp20Br08CYLhnW6uwmfQnGVI/FoYPe5Nl1CPSsd7UVLusiFWM6IlyPYCo6PUWo
 9Z9rMFHc7UeXcsHNFb/d+Jz8Y7Osx5O3Xo1VxVNpan4vItGOm1gHNnlz3DLcM9pdhzANqyWPs
 DWSHQVVtQ5EUnM6H6+HHf6iJTsBojaNvg1bwP/xcv18vGJRSjDeK5J2CkQPL8fTIekEfSTNFI
 wWofDkeYFAjvZoQMQB0QNq6zJ3H77jsOsEEAY1frd1MwltaT3qffuwOBh1t86AzCJEia4YTB/
 zQni4sLwn0GAfmxGgz/E7U0BeucQ1zeD8RR/IRrAlTAWNQatW/AtXNW0oH9GxY0AA06P9B8Mq
 LmnEF09ke43tI9Jyb4/xxMSqmdhDTiKlYSMB/sX5gCLB8h2/KGY9jpWDQCn7n+juAAlGe7OEi
 OcRVX1eLzXWnxrR5codpjKr8lO8Z2iFSElbt/2+KfWWWS8nmT/JjIkF3FTVYZ5BHVIGp295wt
 VSOzKT/Puca/Ye8tfk8RzpyFohfjQCsrNP8WTR4aMGnWT4FkrtYgj7t9Mf+8P8jbrCdOziqpN
 AdqJcglMR299anMt05K18pjvEy/LPQQ6HPZGUhiSevsq+vHHLDf+HGI5HYxZ4ns0269l9wIN8
 1Zm8ioogIRuE3jr1XZ+C5viisScZhEjOaxWwbNNVAo5oFvLBYfa0b90JmsKQw7Bf1BG+rpbpP
 rOKGaacTvwML87RnCBQi/gp0U4t7TF/lA5IEqrpnd+FVSM6myGNq3uO7Sau9iO/GwHnqkppMi
 TjbhDAYcvDiK25KJ84/kEGZ2TITxFb1TIUMIZ7uogypIuPsoqDG8j12TGJ1IXtW/xVXF2o/qF
 jefZ/zfO/LxTvWfopAxR5DSun9Qk7fvbO86OZwvg7R8eVArVghHsMCLq4OKV9t64guPMXMeTr
 l+7FUq4jMAXkUCn6Y/DQ1x9skUlGFwsGAyX0qdx/5dW4WI6kAf8gsMOVFqSS6wfHLeIGo63lm
 HV9tRaoVctzFaKdgX+JvwQia/6UY/hED9miZqKFECHXoy0KncDEAD0nDlsoOkMQcOP4LssI7K
 k5BZzU6/jzyItwqESobsZCfgffrlaPaGUCkCVMBogaRS3OuNTNnuREcPId5z/L80O8xPT8BK8
 zb9R3QtsZU4Ml8OfkZ+/nIKwch/Yed36R+iElY8CyBD7NfzbB8QnaKuXvND0fsVe7M/DpnGSC
 H25kuqkAz1AdIagJdrcK/ifywYook32cejaWnWO2yJ0AsDG1dmfXiWxDa21n78YDy8YvfzPyS
 xJ6K8+4GBKe7+ojyF3VUi84A9i8ZCwZC0a1EBr2Sg39d88EvOCTRZ0OOFD3GdFq4hTXmXbY=

=E2=80=A6
> This patch fixes the condition =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc6#n94

Regards,
Markus
