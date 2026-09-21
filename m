Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C651A154
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029441; cv=none; b=cwf2G+/OClWErzOelU/f2sCBF5Qw8jUM6/XixAsHLxd24mCQ6z347ME4gvhz3O17AHJ4+yTiryZlxn/6vXsgsfxSHnCv4N1U3NWXvsHMAxjOmCvm1yHgVO78ZXDONIuP6BpHZHeFjzjgS4tYtxCAXEWo3me4wETZ8jYoyf9mK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029441; c=relaxed/simple;
	bh=bSLQ8dhyTkMsa0T3MRybn10V2qri87KKmc+w8o1F3xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U58G29OLLBF5gF/f7x29bgmoO4cZb/EAPNTAtR5CHW3uWii9bk83HWQQak/wz3Uq3zdiuo6iR+dF31aGw2mBlV+rzI3Pg8Cq8iT6XIQeYAONqZekNc4GFSFCir/+ftUjUj1pjMLW0SQmCdATSzYZZto4+n3gDlUH2lN2rJ12eXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-482e1e7a4f6so1429677f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 15:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029438; x=1790634238;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZWKBhus7Q6cGpJkKuYawt2j9PRf/Qc0mjhsFcNxeZ9c=;
        b=2R0fvpIjTbM3rRKMPr9Vqta4is8ECCYGPg0Q7Q19DcuTQRgc9IA3mvHsIU61S78Zao
         nEL/RYk1dAsVqglz3lkgzBZvoWBChiBKWQnw1Jyf0ioV8/AWhYF7oQhCZKiS6Y6QbVXP
         5Y+T4UVcXpk6BH+dpTgZgfy26c8n3CIHRU5KJ3Fi3vpopQFGsQXQQQTUPyT5CENyWdoZ
         yhQZ1MPPWo34SzUQBmO16wgDfe4tDJT9sreJDH1jSOWcd+5yxdwh8NLV6HXSb5DVlblK
         G+psmuQxdP30u+VapFoyud+LAILgi7BSTqzZwRgnR4U5N0G5V8R94k7JR43Bf6mfvjit
         DS7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxqIMKMjiWTDmx7d4datWtbfc0byxFSoO4VaG8v7dYMbYE9mzK1/XXwnQPi/DpYDEyk6jfbLl9b1KeIvPg9AT3u1Mo=@vger.kernel.org
X-Gm-Message-State: AFuF++mg8xPiqrXyIAsbCDZ5i8GFO5/LdL4fBNbUUNYXNI0GyRELADQf
	7mgqyOvDeF2yzo1TrCs1KFZWzTKx7ory/9oPJxNBOfd+nexXxw0bw63G
X-Gm-Gg: AYBFou1WnpJvO3BkXDZKWEp+J3PeTW5udKWaNMM/KL6+mJj2G0AROwgyL4RGjZYycs5
	JAgoz7ElrEhAxzhDK5Xqv1yNGFFv5lq/yeHViLepaJL7eZm5B5gz9WDb7b6yIuvDb3W5KhQtLzK
	Zzxdgor3O/0wK4zOHK4hjsBwNa6XEuV2SP7qraXgCZmS+8N1B6pvFYyKfK6NDn6/j8a7OKO+/tN
	/Tn4/81uav98r1yeopHKs5XGuC3jFaEaRZ0H6OH/PNETjzkbPM/04ln8hxdoWjVq+YsNtwn8xe4
	7jVaf4KdhNyQ0Y7f15jwe+Qz2GtCXfFZ4xcjowy/wViPomoxBI8PJi0ZqWKiygkROUAg1gVylzd
	nrIuwGjuINzy4QXZcCC4X4X02pGbxoLp1OrG6usjNXizNJkFSO3PT7OFcWChhia5w5KcgCbAgbS
	eRbey5jiuLnLoibF2knhIWy8IXSMVsCo8enrK/wa1eSYrPOhm8gOhmidUypjY651mu0MuhrR2oh
	k5Gwi1HZHgOFRE+8BwizVPLu/W8EVbuoXkXnfLcu1vTg4FyvA==
X-Received: by 2002:a05:6000:2301:b0:487:a3f:1ea6 with SMTP id ffacd0b85a97d-4871e211724mr18432556f8f.11.1790029437903;
        Mon, 21 Sep 2026 15:23:57 -0700 (PDT)
Received: from [192.168.88.241] (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862244e1asm726393f8f.11.2026.09.21.15.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 15:23:57 -0700 (PDT)
Message-ID: <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
Date: Tue, 22 Sep 2026 00:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
To: Matthieu Baerts <matttbe@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Johannes Berg <johannes.berg@intel.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Adrian Moreno <amorenoz@redhat.com>, Antoine Tenart <atenart@kernel.org>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net>
 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 12:03 AM, Matthieu Baerts wrote:
> Hi Johannes,
> 
> (+Cc openvswitch devs)
> 
> On 21/09/2026 12:06, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> The __print_symbolic() could only ever print the core
>> drop reasons, since that's the way the infrastructure
>> works. Now that we have __print_sym() with all the
>> advantages mentioned in that commit, convert to that
>> and get all the drop reasons from all subsystems. As
>> we already have a list of them, that's really easy.
>>
>> This is a little bit of .text (~100 bytes in my build)
>> and saves a lot of .data (~17k).
> Thank you for working on that! But it looks like it breaks the
> openvswitch test:
> 
> https://netdev-ctrl.bots.linux.dev/logview.html?f=%2Flogs%2Fvmksft%2Fnet%2Fresults%2F833743%2F9-openvswitch-sh%2Fstdout#L168
> 
> Maybe the test needs to be adapted to get the same info differently?
> (and adding CONFIG_TRACEPOINTS to the selftest config file)
The parsing in the test will definitely need to be updated, i.e.,
the numbers swapped with the names of the drop reasons.

IIUC, this change only affects the printing and doesn't affect debugging
tools like retis that attempt to surface the drop reasons.  But, maybe
Adrian and Antoine (CCed) may want to have a glance as well.

Best regards, Ilya Maximets.
