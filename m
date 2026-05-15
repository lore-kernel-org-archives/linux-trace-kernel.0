Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8A494A05
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858791; cv=pass; b=dh8WzCzB2HxvM7L6VnanGbl3RfLJNKipCqUL+JzLLZEwlMV4qvYrqSxrD62MOlwui0Op9e/a/nsBCY6qz8HjmBTCMWrbDbnumJSZ0ztF8Qk/XGh1w9PDss8BN5QQ2cvpvVtwX/ddVDSLYbRsfgkOlWrSG6urfArF5H4tHZWtloo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858791; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=W9YL1FDB0hBt4Qz0AlzBJIc8In7C1Ow74tKndUR8lVKRgEPHKX/QQCcLzEZMsofOUnXgkMhO5Vw0mfKhTjoySIvdqIXu1xOc56psxpo46LrNMBPaj2uF4x0OGJBN4b9WsKaQnRq/G6K1uDHH+qO8/20JD4WKl4wqHrPqj66oI2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6H6atCI; arc=pass smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6H6atCI"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-bce386d5b85so1086974266b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 08:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778858788; cv=none;
        d=google.com; s=arc-20240605;
        b=YNOlysG6h7zcGAWAjrqDz99Q139Nts9rPIJjgthmbhosRZYLLrwkG08XgH1iuTWIqV
         JHB3pX/vcKhWH5mYckZBH7sOyRHToqxg6F+dlNIBMncSOkQtMHQMmM8CzV0IdmgIEy4j
         XN/V7qFr6L7J+DoVCs8mOkMAtV+4EeBsnrS4soRiEsZr6hZny48rqVfmiinX8UDCXVW9
         hbnUCi65QyloAKldUb90/POHgV4rOJ7EPvWaJyDTTGXjX98xLSTjnRWFqGxCYMufyXO2
         oI5s/h4Kiih6cchqrco1f/OFoxVH3/Jq+RMcpxIZ1AExN+JPZVnqHbT+D8IyQWShqzMv
         KVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        fh=ctVcqGxpoBTc6wVR4MrXGKGyP273TLOv1r1Ou813hyY=;
        b=C4ysrRLf3Ys7pNLnywrZiFRAvZv2Sn7arVNLtRrHw1jd1+HWtP4V+HrBfLYRSKHVkE
         3PctoJFxjdpZcmbevx79YDuE3dq6GcxH8aMY8qVRqnf266+eg1KEuYf/ocgJqGXSHTBO
         uBFBbspOay1KVFqE5AQM96H5KUF3Uykn52N7bem1APn/QDumq7cqkRKgAQME5jq95CyG
         dfMD9tdhUKLgpfiE9GfPD2uSboz+M1E2P0gWPLB0KsNyClDGTO51qtE1dgcDSrbBEZvQ
         5IonVeszAimYZ3QLeGXz3KTpqg/gETp048S9k7mp/pyDU8qqvBc0B9FJoPOkGeS3/bRq
         k16w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858788; x=1779463588; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=F6H6atCIuirlIqf/dRpsmmiu06VQA13CRWK7FjR/eQKAl6hxKKNyfz8AbpMY8OEFSW
         F3wu3x/9IbeD2DdhjlyryJdEg1VW4RtGZuzH+EE/WBKGqdOKyqqkHbC+LMRtfokyudkE
         pwKael9ZwWSw/lddj+WwkwsHHmxhJ/S6uTgrL1TUgDOE6E2c4nJt5CdEd+LpSsPPvwGC
         CU2h2VUEqplSs4FIqZIkT/VqNDhEEyL0EMFcBdDhukkuVE+0S4v9KsUEVZ2tD2w0j/H1
         HsM4R8YzUYGzO0ZEupVGvIfPiQmoqyX59Ed0dbQX9BJkqCEDl73g99BipAm17zAXzNKe
         sanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858788; x=1779463588;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=ObYjK+SuT2Phpd6bi8cR8nXIZ9LlnTRXeq0tCCZRZeCur7K6aBIQsdr8a4mqiZvpJ3
         8lkNWSR86j8puTEY+G994jYeesNld0sR7XXJAvmMPZAQVy/9ATUITin18Sad5zrORoC6
         bDpruTaJrQhRBAt2pxdePKAMJeQihvC6orWwZufM1eNXFilOzTnw5UydvjCJ73htOf0o
         88RnAuYplcLdsvJ7VsUD0KKeShmAB3CVUW6+rdKvpW57FYWq+b6f4lRgCCmylTV+e8sr
         zk5sFD4fRka2QljKpGBoZZ0PADfLuo2fI3VLIBcUPin4FCPQbHHItKXFGhwdPzLfs063
         e35A==
X-Gm-Message-State: AOJu0YxQL4AhgfE89kD4MQEtfa2YLyuggOHlubp0Xgw+L5wLKJTnxQCE
	n9H/jF3LT/1z1NSrWrJboYQ6/5My+FZBC/WcSL9faQGsRy6fhOvj6NEutJVYNUD805+M8gD1rdQ
	o9/M9STl1WUPBbOjeRZkR1y7ozwKFoVC4Pt7iLjetOQ==
X-Gm-Gg: Acq92OEmZxC7gWG0ZzOtQgHaPRfiBP9umccAZA/o+JxtVpnwQ0bu7We4f2FxR/+1MEu
	WDlklGNBa3yRdQT0i1YDjC91Ut43Fe+RoPBIoCGF01T5ayitmNk2xpz/yjjwY0ZsyO8h16Na9zY
	pF1T2AOz0/CLs20tlkE5RulflVOsb/NkF/XxtYR9JY1x799x4DwMKIpveKSgfaoG4WnF+/akct3
	gNLomGOh+lKWHuD+GIU66knBd7YIDw17sFlL0huuQGoGW78V8+RWtSxxHCl05jKwFFtbx7oFxOL
	EtfxcoloEG34IQGb
X-Received: by 2002:a17:907:d01:b0:bd5:7c3:aca0 with SMTP id
 a640c23a62f3a-bd517abc8efmr271307866b.48.1778858788429; Fri, 15 May 2026
 08:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: IM AgentX <imagent4bd@gmail.com>
Date: Fri, 15 May 2026 23:26:16 +0800
X-Gm-Features: AVHnY4Jqj2GGckwaMKhTusPy1rQA6DSP2j51cM2ij9LZgOHtD5lrpJc32FKpQ-M
Message-ID: <CANUqUTV=jHVbRuG20Aa_cx_i7JQuX+sfX94WYELAbUiFYS5Vyg@mail.gmail.com>
Subject: 
To: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe
