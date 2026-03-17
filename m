Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A9359A9F;
	Tue, 17 Mar 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745446; cv=none; b=XFiz72NbxJIoPyhjH0LJ7bKIRqek4cflKCE+4cUSxXuLirD2wELhEHpqB4+Z7p6UodiiOt2qmo46NJV2TOcMMsIKUEPNPMkBgkw3BIHyAs8GHlzNjwf3ZUAuUKCzIpb0ARj2GTJkaRYZF1wtzd+dKbCDd86G3soLjtdGHKNHMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745446; c=relaxed/simple;
	bh=hGRp/c2cCZIUpAqVTgd4WrIFvKoPOXR56gz4GqySUPg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kRYpQViEBsVtzc4r1a4Iknt38e6OAZ7cdskyPu2re66X/+dIt/v4uGafoV4PVcErBSf2qB6v+JRcgiv6ASBVu3LfCxW2dydXTzH9WaznhZo421hE5L2cXzopSTMveFwqS/pZFSNB5YYDcNAoXCadxuJpC2Uyjn111ijtwMmLPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NPF4uJz0; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NPF4uJz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773745422; x=1774350222; i=markus.elfring@web.de;
	bh=7f+ZbcKELn6S+ddLfudmYndOxbfonxF5fmzmfknw4No=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NPF4uJz0pucvo9u+YgQBIpIogyB/ZA78wf7QximJ4GiTgDq2UwKuA6rEusnMGrYi
	 G8fjUkkLMNxiTAms62TktmLI1uh7ZMo0jvZeNe34Cmoxou8SwQ9Uo4CCpBiXsCnoY
	 KhuiwBp+GQcgB8Vs/42g+woOsSREaxiGmQ6lfYRhBZQfdU61xhf9jxz4e9gEBthAH
	 /lTKkibMbzEChIW8V2PPNu4SCClySQHo8jBDrCqWwtBZ5gCoaKIJo+GAnX6KUlGak
	 5g2kYB7fOo+I4gHX4vhAjtDN+U6PxC2DL446i4NcPKWDVzksMx/QIMFKhogVKQzfU
	 TRUbzfjJqQhcQMNIjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXGOI-1w6KO02OwY-00OZrE; Tue, 17
 Mar 2026 12:03:42 +0100
Message-ID: <fbe3dbdd-61a4-47e7-90a1-1042caa71129@web.de>
Date: Tue, 17 Mar 2026 12:03:40 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Josh Law <objecting@objecting.org>, linux-trace-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20260315122015.55965-10-objecting@objecting.org>
Subject: Re: [PATCH v6 09/17] lib/bootconfig: validate child node index in
 xbc_verify_tree()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260315122015.55965-10-objecting@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2nNyNCh3NY/KOHGJL11GMTRhBYML15lcMVHwFt/4drXbPbYSW/z
 ndNhrg+bIsQBcId4XdLpQUFDiApvebDCqJJuYMHfY2QH+4jb3o6ELoPKsHi/5m+X85jzerL
 zwbQrXwcacDJQyRI8gURfs6pCXEFyrVRXMWLHPTTRo4CQedDQSNZji5xRy2tOWV+R5p+ta2
 hEFsKvOntBNv19X+0g8KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SRzAeud/hmI=;7Tht7tYqzWAhZoOqdt4t7aGczB1
 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

=E2=80=A6
> +++ b/lib/bootconfig.c
> @@ -823,6 +823,10 @@ static int __init xbc_verify_tree(void)
>  			return xbc_parse_error("No closing brace",
>  				xbc_node_get_data(xbc_nodes + i));
>  		}
> +		if (xbc_nodes[i].child >=3D xbc_node_num) {
> +			return xbc_parse_error("Broken child node",
> +				xbc_node_get_data(xbc_nodes + i));
> +		}
>  	}
=E2=80=A6

How do you think about to omit curly brackets for this if branch?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.0-rc4#n197

Regards,
Markus
