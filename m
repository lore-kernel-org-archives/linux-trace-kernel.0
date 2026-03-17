Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E134BA50;
	Tue, 17 Mar 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780244; cv=pass; b=Ru5dSpLUm9h6GX0SoMMvaOlLy6BOYOtOIMpS6Fq8vLzZX96s5VE9OVngJRH0ViOawXxjmriCZCiJ9GyYOFZCqrahNkrPx+sSCXhf2EoY8MV13bsRx3bekrCeiLa/dyUXi3LmF9RyOnBn9x9CHecw/C5Fn0hUC/RknOoTDbXW6cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780244; c=relaxed/simple;
	bh=dDk9r80tFU4zRbU8i0fAc/L6c54IZ9XCAuBcBUz4n50=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=osF6jT3uectIBn9VY2Rl/m8YyE/tE2DEEeX9AvaFe/Xz4INA4RvqpM90IpTMM3okf2ONSfx3+AXgHINp0dTjqiPNo0rp9mxP5kkFcxkD2bL50ltimEBTFLwZ9cTa/Iko0rHylmGu6VsfwOdlEYHm3hOJTHw/GhK07uAQ6t/b9Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Y+UfrT57; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Y+UfrT57"
ARC-Seal: i=1; a=rsa-sha256; t=1773780230; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bZ9IyGCbt/jE98qJmHObYN928G0hL/dRlM2eOWsyznYeNDEQxDavaXj3jFqK31To1WTA2D6UoiP6c4yquXdiM7gW+O3LmWN9s5+/Lz9mbVLPyJQoJIFV0pZgUUsimt5GDw6ps5cM7nPnYZQb3htPyi4h0fQRUhR0RmzDXZX1fp8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773780230; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UaKl6ZiibKY2oq7TN773jd+JD5O9MyVzfpMulHn4d/M=; 
	b=Fk5bIkRG3K4KdTMdtQRhqx2wnJptJ19/YEccOBtcSRA2fRwIEaYQ50PnOqtSETWttZMDGiFO9hdf004zz5kE+PWFYhlH/6Lh84a+cfWIUr9VsXpvXBE3aYyHmVplv384uq58gJ+ezdlazK33djQoQaXvhR2eTqVfvnV7siVTWjw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773780230;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=UaKl6ZiibKY2oq7TN773jd+JD5O9MyVzfpMulHn4d/M=;
	b=Y+UfrT57L2XtEmubEBJpt//BICGEjf/cs+mvEs6yxvuydWxMnV3Hjn/1jTeFIQON
	Ot89hiQux4MkQy3uJNFOJssCH9vpantJEwpS0KQjiawVF4A0Rr1DEEj+vznLb3kdheC
	p0fXSUbUNF2i6rs+01n1qq2e8owKjMqisfrViwlg=
Received: by mx.zoho.eu with SMTPS id 1773780228462851.1338673237987;
	Tue, 17 Mar 2026 21:43:48 +0100 (CET)
Date: Tue, 17 Mar 2026 20:43:47 +0000
From: Josh Law <objecting@objecting.org>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_lib/bootconfig=3A_guard_x?=
 =?US-ASCII?Q?bc=5Fnode=5Fcompose=5Fkey=5Fafter=28=29_buffer_size?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260317163738.3a7863dd@gandalf.local.home>
References: <20260317181556.53417-1-objecting@objecting.org> <20260317163738.3a7863dd@gandalf.local.home>
Message-ID: <17CE5F51-0C4D-40C3-8F75-2116B2B950DD@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 17 March 2026 20:37:38 GMT, Steven Rostedt <rostedt@goodmis=2Eorg> wrot=
e:
>On Tue, 17 Mar 2026 18:15:56 +0000
>Josh Law <objecting@objecting=2Eorg> wrote:
>
>> xbc_node_compose_key_after() passes a size_t buffer length to
>> snprintf(), but snprintf() returns int=2E Guard against size values abo=
ve
>> INT_MAX before the loop so the existing truncation check can continue t=
o
>> compare ret against (int)size safely=2E
>>=20
>> Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
>> so the same source continues to build there=2E
>>=20
>> Changes since v2:
>>  - Added a comment explaining the INT_MAX guard=2E
>>=20
>> Changes since v1:
>>  - Removed casting ret to size_t; with the INT_MAX guard, the existing
>>    ret >=3D (int)size check is sufficient, per Steven Rostedt=2E
>>  - Link to v1:
>>    https://lore=2Ekernel=2Eorg/all/20260317173703=2E46092-1-objecting@o=
bjecting=2Eorg/
>
>The changes need to be below the '---' so that they don't get pulled into
>the git commit=2E
>
>>=20
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> ---
>
>  <here>
>
>>  lib/bootconfig=2Ec                            | 8 ++++++++
>>  tools/bootconfig/include/linux/bootconfig=2Eh | 5 +++++
>>  2 files changed, 13 insertions(+)
>>=20
>> diff --git a/lib/bootconfig=2Ec b/lib/bootconfig=2Ec
>> index 96cbe6738ffe=2E=2E2a54b51dec5c 100644
>> --- a/lib/bootconfig=2Ec
>> +++ b/lib/bootconfig=2Ec
>> @@ -313,6 +313,14 @@ int __init xbc_node_compose_key_after(struct xbc_n=
ode *root,
>>  	if (!node && root)
>>  		return -EINVAL;
>> =20
>> +	/*
>> +	 * Bootconfig strings never need multi-GB buffers=2E Reject sizes
>> +	 * above INT_MAX so snprintf()'s int return value cannot overflow
>> +	 * the truncation check below=2E
>> +	 */
>> +	if (WARN_ON_ONCE(size > INT_MAX))
>> +		return -EINVAL;
>> +
>>  	while (--depth >=3D 0) {
>>  		node =3D xbc_nodes + keys[depth];
>>  		ret =3D snprintf(buf, size, "%s%s", xbc_node_get_data(node),
>> diff --git a/tools/bootconfig/include/linux/bootconfig=2Eh b/tools/boot=
config/include/linux/bootconfig=2Eh
>> index 6784296a0692=2E=2E48383c10e036 100644
>> --- a/tools/bootconfig/include/linux/bootconfig=2Eh
>> +++ b/tools/bootconfig/include/linux/bootconfig=2Eh
>> @@ -8,6 +8,7 @@
>>  #include <stdbool=2Eh>
>>  #include <ctype=2Eh>
>>  #include <errno=2Eh>
>> +#include <limits=2Eh>
>>  #include <string=2Eh>
>> =20
>> =20
>> @@ -19,6 +20,10 @@
>>  	((cond) ? printf("Internal warning(%s:%d, %s): %s\n",	\
>>  			__FILE__, __LINE__, __func__, #cond) : 0)
>> =20
>> +#ifndef WARN_ON_ONCE
>> +#define WARN_ON_ONCE(cond)	WARN_ON(cond)
>> +#endif
>> +
>>  #define unlikely(cond)	(cond)
>> =20
>>  /* Copied from lib/string=2Ec */
>
>Other than that=2E
>
>Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis=2Eorg>
>
>-- Steve


I'll be convenient,  I'll make a V4 just fixing that, You can just recomme=
nd the reviewed by tag, thanks a lot


V/R


Josh Law
