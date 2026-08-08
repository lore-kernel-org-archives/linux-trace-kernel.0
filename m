Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5C2D9EE4;
	Sat,  8 Aug 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786201220; cv=none; b=eaP+ktYnryVN/lJPGhXP5q05Vz0BK0tH2wHHqCx0Hw0iTEYAhWZSB1t5Y6cyWBAWEvCVLr0rjjr0WeCNU6mA1iZLfaiNoV9Cq5O6bXxgfXmA/2Z6ZxjPOwQL/rUUGpplCciOqPAkWKah89tzv2t4DbjbH890a/0ec+fnnOMs2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786201220; c=relaxed/simple;
	bh=UWeuQlsMm9LV6rdhaKgB51e9eSQ9gquNBCvrDnHE3zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tS+UiHe3r0BYpix29BXofRsKbDfiL1RsRn0M+P/FjDICnZfBV9zB/LF0dec4hHx0E8OzksfL1ARJlWSt7Z0dpYWtR7C184yLrP16wNLgpNO2r9W14IEQPWv8V34L7fxmZig7aHb8ZSFdsU3ucliEFIFlK2F6uteRgBpqUkp6Rug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 81E6E1203F8;
	Sat,  8 Aug 2026 15:00:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 99BFD80012;
	Sat,  8 Aug 2026 15:00:15 +0000 (UTC)
Date: Sat, 8 Aug 2026 11:00:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing/snapshot: Use work_on_cpu to avoid
 -EBUSY during snapshot swap
Message-ID: <20260808110014.03c04ba3@robin>
In-Reply-To: <20260808105855.09f8d794@robin>
References: <20260803005640.2445666-1-wutengda@huaweicloud.com>
	<20260803005640.2445666-3-wutengda@huaweicloud.com>
	<20260808105855.09f8d794@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 99BFD80012
X-Stat-Signature: xx9n55hun3fexafgcxqn1n4pdwdcbd4j
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/KFSHFQ1EPMazw/8EVvepxbHO/iFLsLIY=
X-HE-Tag: 1786201215-643388
X-HE-Meta: U2FsdGVkX1/Wh2qpMfeIEMqWkBLfPZ7mgjDK4EgXOdyEkr5hJnGE4tP+UYYl1J3hxnQfbC5TaHYCb+nQmWpYnHqqAiYoWonn9SNUkPbaKilUSumxe1yBAunQcSd+9NlozNCzC1GrHajil6AxL3rr0FbqBqi6WXYNOksP32VbMDSC0IP9oJRRhVxd1go9VOuuc3jaOtes7ja5MbfISzh2tSgNbw3i6ol65ycsUxyJki/YGc1e9MOAf4h3Zc2Q/tp/anc0gY/P0V0fG8rowQiYS1IuO7MqnZgP25g14gKvX4/qzYkJJWw8aTcbJYq0x95CcNOrS8le/7SgpU6GCX7pxsy2uMcDzzqw6AQ99IALcDIo/haJn8vECQEYZ0prvARmgZSqnmHrAxN3w8uf8Jsd44w9WOdhKOLGzapkUXbw7fi18jxiVsuRb8AwKAkN4jo2Jh2plTIcJr/9rpiI3wR7nA==

On Sat, 8 Aug 2026 10:58:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Sashiko brings up a good point. This will break the recording of what
> task is being interrupted.
> 
>   https://sashiko.dev/#/patchset/20260803005640.2445666-2-wutengda%40huaweicloud.com

I'll apply your fist patch, so you can send new revisions of this patch
as a stand alone. But still start at v3.

-- Steve
