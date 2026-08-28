Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B446C4A7;
	Fri, 28 Aug 2026 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924771; cv=none; b=nVRyYPzkmy0uTEEgovoHv2/oErN6ATwlMd0YQyqGbiToftAAVwcFLMavvSMCwv7WS4/grfjUJLh58lqa1uc/fSaiGAYUqoygdFcpOd7PSpK+6qvXss13heLCsE+8Z6KFDCl/DWCt8yOSLn2VfBb0OJ9B/+j3YVnhaOnJFPUzSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924771; c=relaxed/simple;
	bh=gkSqlDq6APygC/OM/4tvXNaEjzq2vyBt+ttOQovyURw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eIGf4oCNuktxvm14YaGokOl5oDZZB5FhMyANy9r4mU2tjLH+8d0+gjkJ9clPJ1q59COYl02O5kjCmmIRF94oW8xvL7ywL0jxb0EOi5YclnN0oVsnUVivAq+jasAM1GETjQqaWZrVMPvQXZ84Wzbl4kUl5HXcIan9rcp2olM444M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN75zKWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN75zKWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61DC1F00A3A;
	Fri, 28 Aug 2026 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787924766;
	bh=ZkAIK4sJSZ+M6U7rXtAMjWYbvL4XnlFujZHGVX//GSY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=CN75zKWoF+1mzVHhe3/K7jFoShI11b+ruaRcdHTITvn7+SyoPQ9//oA9V4AyNgrWe
	 TEr3RkvkSCUaMk51+gxdYNvZuEJ6RCYWWXKntUXixXkl/UhTCE/+k7RXRrOWw6SiME
	 KIpaJVDj1mx4uZN0AWZKpZrV5HpWiC6l/C2cwy6h/psIZw95h9SheHWNTDXvrBHdFl
	 FQRsmsZl+tBHp0Yp7i0wgVTDygPtb6DY4jWVdyhaPikfGWB5HRfobhDmkRk4cS8PeN
	 ww85C1HqoAvyI5/CV6S9F9RHka7uJNzD0GJeabOQD/nz+tU2QAMPM/UIhBz0P/1tl1
	 r8RRR5G8xq2XQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5F2B21980072;
	Fri, 28 Aug 2026 09:46:03 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 28 Aug 2026 09:46:03 -0400
X-ME-Sender: <xms:F5GRaqE2NkgyW7Ns-LsvSLTTDYKdh01qS6ZTDLQ4fw9t-N0Ddrtc0Q>
    <xme:F5GRamK8JEod1kC8v70PUAKg83EM3BJ4mNsF9zenJckTWXg_DbGiqaZsOaLiTcf1f
    Un5nzICP58n5e2w4IxsrJ6DR2ew4HXCRnU0kgMGarbUP730m9edsSHf>
X-ME-Proxy-Cause: dmFkZTERWf76UbFSBm7gP10dcMTeqKkA8/cAL0sZG2rtqNj9Cm8XygX+z/UkBm5JSSVYUy
    tiYsLDls4/Z8P0ArKeB4JwxyT1aUPV/lD2jc7QsFKIVQHQani//0H1PZEuJk/TiRbXXB2d
    2quRJqkXk73Cy9UXGvcExqZtTKUBQHobcpzJhpw2JFide00btCWCAKJxj+FFD/0LYuztV0
    RDQfQ9I5GuMU2Gp/6HPTrAQR0FUWuP5nz+ODfL0oI1jx4s+jzNT/OxnaNHzIWAbOUDVPAP
    w5fd1Gn9Re9N8rvjRkwEA2WKBs4KNvy7cNDKTIaIdI60cHjToYvMPt6lZJQt9iOoIsFcNt
    RgMeFGqQHwKXp/37eumLweC5yrLclcKzJJT5cNY+IHV1VdIyqIG3ZtBU5HWRsmj47nFXXO
    E35L8lICEmkjQ8uKpI/zFxfHP7ZNKUlS9+8zbra8ZkiUUpsAFf0YCS46pUJJrUCDgx6aMI
    V3tmtGKfMb0aauZJvHtfGU1pRrhYIJs+OLLCQ73AXWjoo3DemVX15rIZX+nlbfZxakHWuF
    qQOXvsSwhEkofy7Mi18iqc/ZOGzI2iapsjruAeX/BsRit5HFPQYWWAYVRwICynS23+3qDa
    lSE1BUqfAQ+/hmaZUT/n/B29/elggaG5nEArlIRIROmCs2ooVKdFgmt50K7A
X-ME-Proxy: <xmx:G5GRaidmDIofxjDrnckkltqpU-EBp3Rle_aBNo2F6P7BC62Z4iDwZQ>
    <xmx:G5GRagLQLLdIZbdkb7L2guevnkadNbHtrAwSNHFCWgxQJ7GeNQ4xXQ>
    <xmx:G5GRasCciwc4APHUJloqDeNMxyVffl53TzupnMualIviek0VAjp3Uw>
    <xmx:G5GRaphOIhi5fNP21BBwmTKuIl5vQHIh-O74BW-RnFIO-oBnHepfnQ>
    <xmx:G5GRamNZICx_vr-e_gFs2Augf5avMnxddCHXulCSvH7Iw1aF3MgajzWL>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 89751F80080; Fri, 28 Aug 2026 09:45:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 15:45:39 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Petr Pavlu" <petr.pavlu@suse.com>, "Ard Biesheuvel" <ardb+git@google.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Aaron Tomlin" <atomlin@atomlin.com>,
 =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Message-Id: <cee89666-9de0-4012-b665-69da3846c5ef@app.fastmail.com>
In-Reply-To: <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
Subject: Re: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, 28 Aug 2026, at 15:07, Petr Pavlu wrote:
> On 8/22/26 3:53 PM, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>> 
>> The arm64 module loader has to deal with a couple of corner cases that
>> may occur when .init.text is placed out of direct branch range of .text:
>> 
>> - ordinary direct branches from .init.text into .text may require the
>>   use of a PLT entry (i.e., a trampoline aka veneer), which means not
>>   only that additional PLT entries need to be allocated for
>>   cross-section calls, but also that .init.text needs its own PLT
>>   reservation, as the one in .text will be out of range as well;
>> 
>> - dynamic patching of the ftrace handler into .init.text code needs its
>>   own dedicated trampoline as the one in .text may be too far away.
>> 
>> - recent compilers may omit BTI veneers for static functions that never
>>   have their address taken, and so additional veneers will need to be
>>   added to .text in case cross-section direct branches from .init.text 
>>   require a PLT entry (and therefore a landing pad at the target end).
>> 
>> This is unfortunate, because it is actually somewhat unusual for .text
>> and .init.text to be so far away from each other: only when allocating
>> either of them (but not both) exhausts the 'near' (PLT-less) module
>> region, the other will be allocated from the spillover region, which is
>> not in direct branching range, and therefore requires PLT entries for
>> cross-section calls.
>> 
>> This series addresses this wart by allocating both of them as a single
>> chunk, and freeing the .init.text part along with the other init
>> sections at the appropriate time. This ensures that the two regions will
>> never require veneers for cross-section calls, allowing the arm64 module
>> loader to be simplified.
>
> It looks like this should also be useful for ppc64, which currently
> merges .init.text and .text because keeping them separate would require
> stubs between the two, and consequently .init.text is never released in
> modules on this architecture.
>

Thanks for the data point - are those stubs needed when there is some
distance between the placements of .text and .init.text?

