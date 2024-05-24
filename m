Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92203482D8;
	Fri, 24 May 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547822; cv=none; b=CHdELZC9hnz6xHL1jjfujTnVG0cu8DPGeJac+0mZffIsAwDSoa9UL6LIOVw6eNlIv+Mm7eZ59mZvLNXm6Nn2dRUFAxeDEdVMPbfyntp+Ij/IYi/nuH07gLLea1dU/0IoC9nF1aHijRIr9a3w7bKri7RAolbCLzZgw0kfy0S3EvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547822; c=relaxed/simple;
	bh=W5iK/L69w1vS5jHqSzlK6AF7Pl8WAdVP/lDrntYBJek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtT3Lr9evlIfQ44G2ELYPdUB92EChOSksOKpSeNGEMiD7Gl7hwwCpHLB7trDbusj5nOOWxhbPK/ueKbZVeMjbIOiMWq89N0rFQ9GFZ0SkZqBXhonUeZdxvpnicZulh8jNLD2EMXwYTuKDnEdyVldfcwExdi2dCX1CHSgYHOUrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vuV92Fr1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vuV92Fr1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Xi0VV02aPT82jOki/4MXoZyGpobBnrrrOZsLV1eML+U=;
	t=1716547818; x=1716979818; b=vuV92Fr1MFPiVmDIIDyp5+OsC1e5TCZP0ceCOqr9r0v/8/3
	qahymqwOQddmwPc3nAxxSyo+zjPDYIeb9VcNU7I4Q+NywT4jIGcSVlvLdVkg5/mZ1JDZ76AiiyPoO
	5jGd8iDmJ9QMVlIQMljtQWIidVClNaY8TG6AvX+HiqEA+WdFc6/jZcmwMknCjBUh3GmCSln1JGdUW
	+l/2VcJ2JtzzLFTZJ5NZBIUzwjF+XmmHkaSynZ9Apq6Di4nGqIt6O0uhAvYxHLlCIfP44kPTF9ZIk
	kPrYr3D3FFdAj48Zwp7Y9e3/Rzi0Y/muITCWS7ttzQs6x86IELiWjgbR87jbS2gw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sASUy-0000GP-TV; Fri, 24 May 2024 12:50:08 +0200
Message-ID: <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
Date: Fri, 24 May 2024 12:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
To: =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?= <digirigawa@gmail.com>,
 stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716547818;62e16c8f;
X-HE-SMSGID: 1sASUy-0000GP-TV

[CCing a few people]

On 24.05.24 12:31, Ilkka Naulapää wrote:
> 
> I have encountered a critical bug in the Linux vanilla kernel that
> leads to a kernel panic during the shutdown or reboot process. The
> issue arises after all services, including `journald`, have been
> stopped. As a result, the machine fails to complete the shutdown or
> reboot procedure, effectively causing the system to hang and not shut
> down or reboot.

Thx for the report. Not my area of expertise, so take this with a gain
of salt. But given the versions your mention in your report and the
screenshot that mentioned tracefs_free_inode I suspect this is caused by
baa23a8d4360d ("tracefs: Reset permissions on remount if permissions are
options"). A few fixes for it will soon hit mainline and are meant to be
backported to affected stable trees:

https://lore.kernel.org/all/20240523212406.254317554@goodmis.org/
https://lore.kernel.org/all/20240523174419.1e5885a5@gandalf.local.home/

You might want to try them – or recheck once they hit the stable trees
you are about. If they don't work, please report back.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> Here are the details of the issue:
> 
> - Affected Versions: Before kernel version 6.8.10, the bug caused a
> quick display of a kernel trace dump before the shutdown/reboot
> completed. Starting from version 6.8.10 and continuing into version
> 6.9.0 and 6.9.1, this issue has escalated to a kernel panic,
> preventing the shutdown or reboot from completing and leaving the
> machine stuck.
> 
> - Symptoms:
>   - In normal shutdown/reboot scenarios, the kernel trace dump briefly
> appears as the last message on the screen.
>   - In rescue mode, the kernel panic message is displayed. Normally it
> is not shown.
> 
> Since `journald` is stopped before this issue occurs, no textual logs
> are available. However, I have captured two pictures illustrating
> these related issues, which I am attaching to this email for your
> reference. Also added my custom kernel config.
> 
> Thank you for your attention to this matter. Please let me know if any
> additional information is required to assist in diagnosing and
> resolving this bug.
> 
> Best regards,
> 
> Ilkka Naulapää
