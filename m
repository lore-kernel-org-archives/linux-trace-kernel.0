Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7046C83D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089700; cv=none; b=ryULX6chwolpjyz5IW0eKr13e0OgIgJ7mGJQvi9tbhyEXUOnYo7aNYojOLRWUQp46OVzO+994MOAw3q3j/VI/yQgLOe53IIdf6v+1ojzeEigLGVUXmNMiwbmWGmAOsKiOegEPLfpeN4b6G+Ywqg5pHeyS9RuvSgAfsH83n4I2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089700; c=relaxed/simple;
	bh=FpWnexbTRPZZjWnkVgOVliYNIT8UTJAknZ1Ml5PJrm8=;
	h=From:References:Content-Type:To:Subject:Date:In-Reply-To:Cc:
	 Message-Id:Mime-Version; b=T9LMu4BxII1Yp0FdjF3gOfrjVremRuefsS9NywyrJpQQEpzIutQ1PdgowLMWKN58RXdDR9H9+eMiPufOd7flenwQK58LxESch+BCv2x7262JbEUcKjXzwsJj0gTwkmudYxwqLVicRRr95pKMYJdCSJfEYRiK0NM1iFoiUc64YZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hLwvAyFV; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hLwvAyFV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786089686; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nLOA9Bye6eC2C0r/n8G6G6RgBNHXoYHLuuMhRrEPYzM=;
 b=hLwvAyFVQFNtmHKD6/cL0VdyyF1mI2r7vPdw9JwM6DrUNZDUGLMmpxVYX6GS14bqY4/fca
 iBimsrDG7Mv509SwZ3jo3NkM13a6/8k20gIAgxMd1BQT0klC3Dadc/qlbeSZPkLU1Ve5I4
 JMtQg+LIDwrZcOElXj/TgUIxc2WTSTq6aSfTvdJb4jvzJ9mCE4oGA6LBtqsv5kmfNkMIpJ
 DPBK9JzOerCy2HXv9s7nYsDVU1qh3MMAOi/nOK+k2aEUUq4qo5ahM9ZPLPQnzmwEF9ZVnc
 xNRrv8EZ/WBmsTDDuJGZJONK52L1xt0CmmeY1njN673SBfksnwp7Nr4amApHyQ==
User-Agent: Mozilla Thunderbird
From: "Rui Qi" <qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20260806083101.2651025-1-qirui.001@bytedance.com> <20260807104709.0626fd20ed7618273dcbead2@kernel.org>
Content-Type: text/plain; charset=UTF-8
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2] selftests/ftrace: Force C locale for readelf in uprobe test
Date: Fri, 7 Aug 2026 16:01:05 +0800
In-Reply-To: <20260807104709.0626fd20ed7618273dcbead2@kernel.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, 
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Shuah Khan" <shuah@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Message-Id: <a1f16b86-89ca-4286-841b-da9a081c8d33@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a7590d1+dfa1de+vger.kernel.org+qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit

On 8/7/26 9:47 AM, Masami Hiramatsu (Google) wrote:
> On Thu,  6 Aug 2026 16:31:00 +0800
> "Rui Qi" <qirui.001@bytedance.com> wrote:
> 
>> The add_remove_uprobe test parses the entry point from readelf -h output
>> by looking for the English "Entry" field. readelf output is localized
>> via gettext, while the ftracetest runner does not force LC_ALL=C and the
>> top-level Makefile leaves LANG effective for child processes.
> 
> Hmm, to make it safer, I think we should force LC_ALL=C in the top level
> of ftracetest, instead of setting it in each test case.
> 
> Thank you,
> 

Thank you for the suggestion.

Agreed, setting LC_ALL=C in the ftracetest runner is better than fixing
this one readelf invocation. I will update ftracetest to export LC_ALL=C
so all test cases inherit the C locale, and send a v2.

Thanks,
Rui


>>
>> If readelf prints a translated field name, ENTRYPOINT becomes empty and
>> the uprobe_events write is rejected because the offset after PATH: is
>> missing.
>>
>> Run readelf with LC_ALL=C so the parsed header field remains stable
>> across locales.
>>
>> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
>> ---
>>  .../selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc       | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
>> index f2048c244526..f33a863be68b 100644
>> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
>> @@ -12,7 +12,7 @@ echo 0 > events/enable
>>  echo > dynamic_events
>>  
>>  REALBIN=`readlink -f /bin/sh`
>> -ENTRYPOINT=`readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
>> +ENTRYPOINT=`LC_ALL=C readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
>>  
>>  echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
>>  
>> -- 
>> 2.20.1
> 
